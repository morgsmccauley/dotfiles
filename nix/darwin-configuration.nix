{ config, pkgs, lib, ... }:

{
  imports = [
    ./home.nix
    ./defaults.nix
    ./homebrew.nix
  ];

  services.yabai = {
    enable = true;

    # where is this placed?
    config = {
      layout = "bsp";

      top_padding = 25;
      bottom_padding = 25;
      left_padding = 25;
      right_padding = 25;
      window_gap = 25;

      window_border = "on";
      window_border_hidpi = "on";
      window_border_blur = "off";

      active_window_border_color = "0xFFE55C9C";
      normal_window_border_color = "0xe55c9c";
    };

    extraConfig = ''
      yabai -m rule --add app="^System Preferences$" sticky=on manage=off
      yabai -m rule --add app="^Finder$" sticky=on manage=off
      yabai -m rule --add app="^System Information$" sticky=on manage=off
      yabai -m rule --add app="^Activity Monitor$" sticky=on manage=off
      yabai -m rule --add app="^Messages$" sticky=on manage=off
      yabai -m rule --add app="^Karabiner-Elements$" sticky=on manage=off
      yabai -m rule --add app="^Karabiner-EventViewer$" sticky=on manage=off
      yabai -m rule --add app="^Preview$" sticky=on manage=off
      yabai -m rule --add app="^Keychain Access$" sticky=on manage=off
      yabai -m rule --add app="^BetterTouchTool$" sticky=on manage=off
      yabai -m rule --add app="^Contexts$" sticky=on manage=off
      yabai -m rule --add app="^Music$" sticky=on manage=off
      yabai -m rule --add app="^Home$" sticky=on manage=off
      yabai -m rule --add app="^Notes$" sticky=on manage=off
      yabai -m rule --add app="^Docker Desktop$" sticky=on manage=off
      yabai -m rule --add app="^Reminders$" sticky=on manage=off
    '';
  };

  services.karabiner-elements.enable = true;

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Create /etc/zshrc that loads the nix-darwin environment.
  # This needs to be enabled for the environment to be setup correctly
  programs.zsh = {
    enable = true;
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
