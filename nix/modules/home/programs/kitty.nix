{ pkgs, ... }: {
  programs.kitty = {
    enable = true;

    package = pkgs.kitty.overrideAttrs (oldAttrs: {
      version = "0.38.1";
      src = pkgs.fetchFromGitHub {
        owner = "kovidgoyal";
        repo = "kitty";
        rev = "v0.38.1";
        hash = "sha256-0M4Bvhh3j9vPedE/d+8zaiZdET4mXcrSNUgLllhaPJw=";
      };
    });

    settings = {
      font_family = "Hack Nerd Font Regular";
      bold_font = "Hack Nerd Font Bold";
      italic_font = "Hack Nerd Font Italic";
      bold_italic_font = "Hack Nerd Font Bold Italic";
      font_size = "13";
      disable_ligatures = "always";
      cursor_shape = "underline";
      cursor_blink_interval = "0";
      mouse_hide_wait = "-1";
      tab_bar_edge = "top";
      tab_bar_style = "separator";
      tab_separator = " | ";
      allow_remote_control = "yes";
      listen_on = "unix:/tmp/kitty";
      shell_integration = "enabled no-cursor";
      macos_thinken_font = "0.25";
    };

    extraConfig = ''
      enabled_layouts stack
    '';

    keybindings = {
      "cmd+1" = "goto_tab 1";
      "cmd+2" = "goto_tab 2";
      "cmd+3" = "goto_tab 3";
      "cmd+4" = "goto_tab 4";
      "cmd+5" = "goto_tab 5";
      "cmd+6" = "goto_tab 6";
      "cmd+7" = "goto_tab 7";
      "cmd+8" = "goto_tab 8";
      "cmd+9" = "goto_tab 9";
      "kitty_mod+t" = "no_op";
    };

    themeFile = "Catppuccin-Macchiato";
  };
}
