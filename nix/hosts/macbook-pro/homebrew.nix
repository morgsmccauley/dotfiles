{ config, ... }: {
  homebrew = {
    enable = true;
    onActivation.cleanup = "none";
    taps = [
      "homebrew/services"
    ];
    caskArgs = {
      appdir = "/Applications";
      require_sha = true;
    };
    brews = [
      "ansible"
      "docker-compose"
    ];
    casks = [
      "raycast"
      "docker"
      "1password-cli"
      "1password"
      "karabiner-elements"
      "brave-browser"
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

  system.activationScripts.postUserActivation.text = ''
    if [ ! -L ~/.docker/cli-plugins/docker-compose ]; then
        echo "Linking compose plugin to docker CLI"

        mkdir -p ~/.docker/cli-plugins
        ln -sfn ${config.homebrew.brewPrefix}/docker-compose ~/.docker/cli-plugins/docker-compose
    fi
  '';
}
