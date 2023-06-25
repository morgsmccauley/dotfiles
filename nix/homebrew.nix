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

  system.activationScripts.preUserActivation.text = ''
    if ! command -v ${config.homebrew.brewPrefix}/brew &> /dev/null; then
        echo "Installing brew"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
  '';
}
