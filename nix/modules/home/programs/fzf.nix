{ ... }: {
  programs.fzf = {
    enable = true;

    defaultOptions = [
      "--layout reverse"
      "--bind ctrl-u:preview-page-up,ctrl-d:preview-page-down"
    ];

    # # Catppuccin-Macchiato
    # colors = {
    #   "bg" = "#24273a";
    #   "bg+" = "#24273a";
    #   "spinner" = "#f4dbd6";
    #   "hl" = "#ed8796";
    #   "fg" = "#cad3f5";
    #   "header" = "#ed8796";
    #   "info" = "#c6a0f6";
    #   "pointer" = "#f4dbd6";
    #   "marker" = "#f4dbd6";
    #   "fg+" = "#cad3f5";
    #   "prompt" = "#c6a0f6";
    #   "hl+" = "#ed8796";
    # };

    # # Catppuccin-Latte
    # colors = {
    #   "bg" = "#eff1f5";
    #   "bg+" = "#eff1f5";
    #   "spinner" = "#dc8a78";
    #   "hl" = "#d20f39";
    #   "fg" = "#4c4f69";
    #   "header" = "#d20f39";
    #   "info" = "#8839ef";
    #   "pointer" = "#dc8a78";
    #   "marker" = "#dc8a78";
    #   "fg+" = "#4c4f69";
    #   "prompt" = "#8839ef";
    #   "hl+" = "#d20f39";
    # };
  
    # Catppuccin-Mocha
    colors = {
      "bg" = "#1e1e2e";
      "bg+" = "#313244";
      "spinner" = "#f5e0dc";
      "hl" = "#f38ba8";
      "fg" = "#cdd6f4";
      "header" = "#f38ba8";
      "info" = "#cba6f7";
      "pointer" = "#f5e0dc";
      "marker" = "#b4befe";
      "fg+" = "#cdd6f4";
      "prompt" = "#cba6f7";
      "hl+" = "#f38ba8";
      "selected-bg" = "#45475a";
    };
  };
}
