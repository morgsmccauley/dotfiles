#!/usr/bin/env python3
"""Query Datadog metrics in the us5 site."""

from __future__ import annotations

import argparse
import json
import os
import re
import time
from datetime import datetime, timezone
from typing import Any
from urllib import error, parse, request

DEFAULT_SITE = os.environ.get("DATADOG_SITE", "")
DEFAULT_API_KEY = os.environ.get("DATADOG_API_KEY", "")
DEFAULT_APP_KEY = os.environ.get("DATADOG_APP_KEY", "")

TIME_EXPR_RE = re.compile(r"^now(?:(?P<sign>[+-])(?P<amount>\d+)(?P<unit>[smhdw]))?$")
UNIT_TO_SECONDS = {
    "s": 1,
    "m": 60,
    "h": 3600,
    "d": 86400,
    "w": 604800,
}


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Access Datadog metrics in the us5 site."
    )
    parser.add_argument(
        "--site",
        default=os.environ.get("DD_SITE", DEFAULT_SITE),
        help="Datadog site host, for example us5.datadoghq.com.",
    )
    parser.add_argument(
        "--api-key",
        default=os.environ.get("DD_API_KEY", DEFAULT_API_KEY),
        help="Datadog API key. Defaults to DATADOG_API_KEY or DD_API_KEY.",
    )
    parser.add_argument(
        "--app-key",
        default=os.environ.get("DD_APP_KEY", DEFAULT_APP_KEY),
        help="Datadog application key. Defaults to DATADOG_APP_KEY or DD_APP_KEY.",
    )
    parser.add_argument(
        "--output",
        choices=("text", "json"),
        default="text",
        help="Choose a concise text summary or the raw JSON response.",
    )

    subparsers = parser.add_subparsers(dest="command", required=True)

    list_active = subparsers.add_parser(
        "list-active",
        help="List active metric names for a time window.",
    )
    list_active.add_argument(
        "--from",
        dest="from_time",
        default="now-24h",
        help="Start time: now-24h, 2026-03-27T00:00:00Z, or epoch.",
    )
    list_active.add_argument(
        "--host",
        help="Optional host filter passed through to Datadog.",
    )
    list_active.add_argument(
        "--tag-filter",
        help="Optional tag filter passed through to Datadog.",
    )
    list_active.add_argument(
        "--prefix",
        help="Filter the returned metric names by prefix after fetching them.",
    )
    list_active.add_argument(
        "--limit",
        type=int,
        default=100,
        help="Maximum number of metric names to print in text mode.",
    )

    query = subparsers.add_parser(
        "query",
        help="Query timeseries points with a Datadog query string.",
    )
    query.add_argument(
        "query",
        help="A Datadog query string such as avg:validator_api.current_slot{env:prod}.",
    )
    query.add_argument(
        "--from",
        dest="from_time",
        default="now-15m",
        help="Start time: now-15m, 2026-03-27T00:00:00Z, or epoch.",
    )
    query.add_argument(
        "--to",
        dest="to_time",
        default="now",
        help="End time: now, 2026-03-27T01:00:00Z, or epoch.",
    )
    query.add_argument(
        "--limit",
        type=int,
        default=20,
        help="Maximum number of series to print in text mode.",
    )
    query.add_argument(
        "--show-points",
        type=int,
        default=0,
        help="Show the N most recent non-null points for each printed series.",
    )

    tags = subparsers.add_parser(
        "tags",
        help="List tags available for a metric name.",
    )
    tags.add_argument("metric_name", help="Metric name, not a query expression.")
    tags.add_argument(
        "--configured-only",
        action="store_true",
        help="Ask Datadog for configured tags only.",
    )

    return parser.parse_args()


def normalize_api_host(site: str) -> str:
    cleaned = site.strip()
    cleaned = re.sub(r"^https?://", "", cleaned)
    cleaned = cleaned.rstrip("/")
    if cleaned.startswith("api."):
        return cleaned
    return f"api.{cleaned}"


def parse_time_expr(value: str, *, now: int | None = None) -> int:
    raw = value.strip()
    if not raw:
        raise ValueError("time value cannot be empty")

    if now is None:
        now = int(time.time())

    match = TIME_EXPR_RE.match(raw.lower())
    if match:
        sign = match.group("sign")
        if not sign:
            return now
        amount = int(match.group("amount"))
        unit = match.group("unit")
        delta = amount * UNIT_TO_SECONDS[unit]
        return now + delta if sign == "+" else now - delta

    if raw.isdigit():
        timestamp = int(raw)
        if timestamp > 10_000_000_000:
            timestamp //= 1000
        return timestamp

    iso_value = raw.replace("Z", "+00:00")
    try:
        dt = datetime.fromisoformat(iso_value)
    except ValueError as exc:
        raise ValueError(
            f"unsupported time value {value!r}; use now-15m, ISO-8601, or epoch"
        ) from exc

    if dt.tzinfo is None:
        dt = dt.replace(tzinfo=timezone.utc)
    return int(dt.timestamp())


def format_epoch(timestamp: float) -> str:
    seconds = timestamp / 1000 if timestamp > 10_000_000_000 else timestamp
    dt = datetime.fromtimestamp(seconds, tz=timezone.utc)
    return dt.isoformat().replace("+00:00", "Z")


def json_dump(data: Any) -> None:
    print(json.dumps(data, indent=2, sort_keys=True))


class DatadogClient:
    def __init__(self, site: str, api_key: str, app_key: str) -> None:
        missing = []
        if not site.strip():
            missing.append("DATADOG_SITE or --site")
        if not api_key.strip():
            missing.append("DATADOG_API_KEY, DD_API_KEY, or --api-key")
        if not app_key.strip():
            missing.append("DATADOG_APP_KEY, DD_APP_KEY, or --app-key")
        if missing:
            raise SystemExit(f"Missing Datadog configuration: {', '.join(missing)}")

        self.api_host = normalize_api_host(site)
        self.api_key = api_key
        self.app_key = app_key

    def get(self, path: str, params: dict[str, Any] | None = None) -> Any:
        query = parse.urlencode(
            {key: value for key, value in (params or {}).items() if value is not None}
        )
        url = f"https://{self.api_host}{path}"
        if query:
            url = f"{url}?{query}"

        req = request.Request(
            url,
            headers={
                "Accept": "application/json",
                "DD-API-KEY": self.api_key,
                "DD-APPLICATION-KEY": self.app_key,
            },
            method="GET",
        )
        try:
            with request.urlopen(req, timeout=30) as response:
                return json.loads(response.read().decode("utf-8"))
        except error.HTTPError as exc:
            body = exc.read().decode("utf-8", errors="replace")
            message = body
            try:
                parsed = json.loads(body)
                message = json.dumps(parsed, sort_keys=True)
            except json.JSONDecodeError:
                pass
            raise SystemExit(f"Datadog API error ({exc.code}): {message}") from exc
        except error.URLError as exc:
            raise SystemExit(f"Failed to reach Datadog API: {exc.reason}") from exc


def handle_list_active(args: argparse.Namespace, client: DatadogClient) -> None:
    from_time = parse_time_expr(args.from_time)
    payload = client.get(
        "/api/v1/metrics",
        params={
            "from": from_time,
            "host": args.host,
            "tag_filter": args.tag_filter,
        },
    )
    metrics = sorted(payload.get("metrics", []))
    if args.prefix:
        metrics = [metric for metric in metrics if metric.startswith(args.prefix)]

    if args.output == "json":
        json_dump(
            {
                "from": from_time,
                "from_iso": format_epoch(from_time),
                "count": len(metrics),
                "metrics": metrics,
            }
        )
        return

    print(f"active metrics since {format_epoch(from_time)}: {len(metrics)}")
    for metric in metrics[: args.limit]:
        print(metric)
    if len(metrics) > args.limit:
        print(f"... {len(metrics) - args.limit} more")


def recent_points(series: dict[str, Any], count: int) -> list[tuple[float, float]]:
    points: list[tuple[float, float]] = []
    for point in series.get("pointlist", []):
        if (
            isinstance(point, list)
            and len(point) == 2
            and point[0] is not None
            and point[1] is not None
        ):
            points.append((float(point[0]), float(point[1])))
    return points[-count:] if count > 0 else points


def handle_query(args: argparse.Namespace, client: DatadogClient) -> None:
    now = int(time.time())
    from_time = parse_time_expr(args.from_time, now=now)
    to_time = parse_time_expr(args.to_time, now=now)
    if from_time >= to_time:
        raise SystemExit("--from must be earlier than --to")

    payload = client.get(
        "/api/v1/query",
        params={
            "from": from_time,
            "to": to_time,
            "query": args.query,
        },
    )

    if args.output == "json":
        json_dump(payload)
        return

    series_list = payload.get("series", [])
    print(f"query: {payload.get('query', args.query)}")
    print(
        f"window: {format_epoch(from_time)} -> {format_epoch(to_time)}"
    )
    print(f"series: {len(series_list)}")
    for index, series in enumerate(series_list[: args.limit], start=1):
        metric = (
            series.get("display_name")
            or series.get("metric")
            or series.get("expression")
            or args.query
        )
        scope = series.get("scope") or ",".join(series.get("tag_set", [])) or "*"
        points = recent_points(series, 0)
        if not points:
            print(f"{index}. {metric} [{scope}] no non-null points")
            continue

        latest_ts, latest_value = points[-1]
        interval = series.get("interval")
        print(
            f"{index}. {metric} [{scope}] latest={latest_value} at {format_epoch(latest_ts)} "
            f"points={len(points)} interval={interval}s"
        )
        if args.show_points > 0:
            samples = ", ".join(
                f"{format_epoch(ts)}={value}" for ts, value in recent_points(series, args.show_points)
            )
            print(f"   recent: {samples}")

    if len(series_list) > args.limit:
        print(f"... {len(series_list) - args.limit} more series")


def handle_tags(args: argparse.Namespace, client: DatadogClient) -> None:
    payload = client.get(
        f"/api/v2/metrics/{parse.quote(args.metric_name, safe='')}/all-tags",
        params={
            "filter[configured]": "true" if args.configured_only else None,
        },
    )

    if args.output == "json":
        json_dump(payload)
        return

    tags = payload.get("data", {}).get("attributes", {}).get("tags", [])
    print(f"metric: {args.metric_name}")
    print(f"tags: {len(tags)}")
    for tag in tags:
        print(tag)


def main() -> None:
    args = parse_args()
    client = DatadogClient(args.site, args.api_key, args.app_key)

    if args.command == "list-active":
        handle_list_active(args, client)
    elif args.command == "query":
        handle_query(args, client)
    elif args.command == "tags":
        handle_tags(args, client)
    else:
        raise SystemExit(f"unknown command: {args.command}")


if __name__ == "__main__":
    main()
