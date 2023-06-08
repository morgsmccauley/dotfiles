{ config, pkgs, lib, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [
    pkgs.vim
    pkgs.fzf
    pkgs.jq
    pkgs.ripgrep
    pkgs.neovim
    pkgs.kitty
    pkgs.navi
    pkgs.zoxide
    pkgs.google-cloud-sdk
    pkgs.nodejs_18
    pkgs.rustup
    pkgs.monitorcontrol
    pkgs.gh
    pkgs.starship
    pkgs.nodePackages.serverless
    # unfree license
    # pkgs.raycast
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
    casks = [
      # "monitorcontrol"
      "raycast"
      "docker"
      "obsidian"
    ];
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

  package.zoxide = {
    enable = true;
    enableZshIntegration = true;
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

}
