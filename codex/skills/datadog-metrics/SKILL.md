---
name: datadog-metrics
description: Access Datadog metrics in the us5 site with environment-provided credentials and the helper script. Use when Codex needs to discover active metric names, query timeseries data, inspect metric tags, or answer monitoring questions from Datadog metrics.
---

# Datadog Metrics

Use this skill for Datadog metric work against `us5.datadoghq.com`. The helper script reads credentials from environment variables, so the common path is to export them once and run the script instead of hand-writing `curl` commands.

## Quick Start

Run [scripts/datadog_metrics.py](/Users/morganmccauley/.dotfiles/codex/skills/datadog-metrics/scripts/datadog_metrics.py) from the repo root or by absolute path.

Set credentials first:

```bash
export DATADOG_SITE=us5.datadoghq.com
export DATADOG_API_KEY=...
export DATADOG_APP_KEY=...
```

Common commands:

```bash
python3 codex/skills/datadog-metrics/scripts/datadog_metrics.py list-active --from now-24h --prefix validator_api.
python3 codex/skills/datadog-metrics/scripts/datadog_metrics.py query 'avg:validator_api.current_slot{env:prod}' --from now-30m
python3 codex/skills/datadog-metrics/scripts/datadog_metrics.py tags validator_api.current_slot
```

## Workflow

### 1. Discover the metric name first

If the user gives a rough description instead of an exact metric name, start with `list-active`.

- Use `--prefix` to narrow broad namespaces.
- Use `--limit` to keep output small.
- Use `--from now-24h` or another explicit window so the result is easy to justify.

Example:

```bash
python3 codex/skills/datadog-metrics/scripts/datadog_metrics.py list-active --from now-24h --prefix transaction_monitor.
```

### 2. Query a timeseries

Use `query` once you know the metric expression.

- Pass a Datadog query string exactly as Datadog expects it, for example `avg:metric.name{tag:value}`.
- Prefer explicit windows such as `--from now-15m --to now`.
- Add `--show-points N` when the user needs the most recent raw samples.
- Add `--output json` when another tool or script will consume the result.

Supported time formats:

- Relative: `now`, `now-15m`, `now-2h`, `now-7d`
- Absolute ISO-8601: `2026-03-27T09:00:00Z`
- Unix epoch seconds or milliseconds

Example:

```bash
python3 codex/skills/datadog-metrics/scripts/datadog_metrics.py query \
  'avg:validator_api.current_slot{env:prod}' \
  --from now-1h \
  --show-points 5
```

### 3. Inspect tags for a metric

Use `tags` when the user needs to know which tags are available for slicing a metric.

- Start without filters.
- Add `--configured-only` to show only configured tags when the full set is noisy.

Example:

```bash
python3 codex/skills/datadog-metrics/scripts/datadog_metrics.py tags validator_api.current_slot --configured-only
```

## Operational Notes

- The script reads defaults from `DATADOG_SITE`, `DATADOG_API_KEY`, and `DATADOG_APP_KEY`.
- Use `DD_SITE`, `DD_API_KEY`, or `DD_APP_KEY` for one-off overrides, or pass CLI flags directly.
- Keep answers grounded in the queried window. If the user says "today" or "now," echo the actual time window you used.
- This skill is for metrics. If the task is really about logs, traces, dashboards, or monitors, use a different workflow.
