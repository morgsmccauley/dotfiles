{ pkgs, lib, ... }: {
  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
  };

  xdg.configFile."wezterm/wezterm.lua".source = ./wezterm.lua;
}
