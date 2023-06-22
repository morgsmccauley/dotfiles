{ config, pkgs, lib, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  imports = [ <home-manager/nix-darwin> ];

  users.users = {
    morganmccauley = {
      name = "morganmccauley";
      home = "/Users/morganmccauley";
    };
  };

  home-manager = {
    # useUserPackages = true;
    useGlobalPkgs = true;
    users = {
      morganmccauley = { pkgs, ... }: {
        home.stateVersion = "23.05";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    vim
    fzf
    jq
    yq
    ripgrep
    neovim
    kitty
    navi
    zoxide
    google-cloud-sdk
    awscli2
    nodejs_18
    rustup
    monitorcontrol
    gh
    starship
    terraform
    postgresql_14
    redis
    httpie
    neovim-remote
    nodePackages.serverless
  ];

  services.yabai = {
    enable = true;
    package = pkgs.yabai;
  };

  # /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
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
      # Also need to run:
      # mkdir -p ~/.docker/cli-plugins
      # ln -sfn $HOMEBREW_PREFIX/opt/docker-compose/bin/docker-compose ~/.docker/cli-plugins/docker-compose
      "docker-compose"
    ];
    casks = [
      # "monitorcontrol"
      "raycast"
      "docker"
      "obsidian"
    ];
    masApps = {
      "Shortery" = 1594183810;
      "Slack" = 803453959;
    };
  };

  services.karabiner-elements.enable = true;

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh = {
    enable = true;
    enableSyntaxHighlighting = true;
    enableFzfHistory = true;
    enableFzfCompletion = true;
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  system.defaults.NSGlobalDomain.InitialKeyRepeat = 10;
  system.defaults.NSGlobalDomain.KeyRepeat = 1;
  system.defaults.NSGlobalDomain._HIHideMenuBar = true;

  system.defaults.trackpad.TrackpadThreeFingerDrag = true;
  system.defaults.trackpad.Clicking = true;
  system.defaults.trackpad.ActuationStrength = 0;

  system.defaults.dock.autohide = true;
  system.defaults.dock.show-process-indicators = true;
  system.defaults.dock.show-recents = true;
  system.defaults.dock.static-only = true;
  system.defaults.dock.mru-spaces = false;

  system.defaults.finder.ShowPathbar = true;
  system.defaults.finder.AppleShowAllFiles = true;

  system.defaults.loginwindow.GuestEnabled = false;

  system.defaults.LaunchServices.LSQuarantine = false;

  # system.defaults.CustomUserPreferences = {
  #   "com.apple.Dock" = {
  #     "static-others" = ''<array><dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>file:///Users/morganmccauley/Downloads/</string><key>_CFURLStringType</key><integer>15</integer></dict><key>file-type</key><integer>2</integer><key>showas</key><integer>2</integer><key>displayas</key><integer>1</integer><key>file-label</key><string>Downloads</string><key>url</key><string>file:///Users/morganmccauley/Downloads/</string></dict><key>tile-type</key><string>directory-tile</string></dict><dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>file:///Applications/</string><key>_CFURLStringType</key><integer>15</integer></dict><key>file-type</key><integer>2</integer><key>showas</key><integer>2</integer><key>displayas</key><integer>1</integer><key>file-label</key><string>Applications</string><key>url</key><string>file:///Applications/</string></dict><key>tile-type</key><string>directory-tile</string></dict><dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>file:///Users/morganmccauley/Documents/</string><key>_CFURLStringType</key><integer>15</integer></dict><key>file-type</key><integer>2</integer><key>showas</key><integer>2</integer><key>displayas</key><integer>1</integer><key>file-label</key><string>Documents</string><key>url</key><string>file:///Users/morganmccauley/Documents/</string></dict><key>tile-type</key><string>directory-tile</string></dict><dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>file:///Users/morganmccauley/Developer/</string><key>_CFURLStringType</key><integer>15</integer></dict><key>file-type</key><integer>2</integer><key>showas</key><integer>2</integer><key>displayas</key><integer>1</integer><key>file-label</key><string>Developer</string><key>url</key><string>file:///Users/morganmccauley/Developer/</string></dict><key>tile-type</key><string>directory-tile</string></dict></array>'';
  #   };
  # };
}
