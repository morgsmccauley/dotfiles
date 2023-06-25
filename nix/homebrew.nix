{ config, ... }:

{
  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "uninstall";
    };
    taps = [
      "homebrew/cask"
    ];
    caskArgs = {
      appdir = "/Applications";
      require_sha = true;
    };
    brews = [
      "docker-compose"
    ];
    casks = [
      "raycast"
      "docker"
      "obsidian"
    ];
    masApps = {
      "Shortery" = 1594183810;
      "Slack" = 803453959;
    };
  };
}
