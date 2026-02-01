{ pkgs, lib, ... }: {
  programs.ghostty = {
    enable = true;
    # nixpkgs doesn't support darwin, installed via brew
    package = null;

    settings = {
      font-family = "Hack Nerd Font";
      font-size = 13;
      font-style = "Regular";
      font-style-bold = "Bold";
      font-style-italic = "Italic";
      font-style-bold-italic = "Bold Italic";
      font-feature = "-liga";

      cursor-style = "underline";
      cursor-style-blink = false;

      mouse-hide-while-typing = true;

      shell-integration = "zsh";
      shell-integration-features = "no-cursor";

      macos-option-as-alt = true;

      theme = "light:Catppuccin Latte,dark:Catppuccin Mocha";

      keybind = [
        "cmd+one=goto_tab:1"
        "cmd+two=goto_tab:2"
        "cmd+three=goto_tab:3"
        "cmd+four=goto_tab:4"
        "cmd+five=goto_tab:5"
        "cmd+six=goto_tab:6"
        "cmd+seven=goto_tab:7"
        "cmd+eight=goto_tab:8"
        "cmd+nine=goto_tab:9"
      ];
    };
  };
}
