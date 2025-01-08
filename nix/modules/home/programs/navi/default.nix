{ ... }: {
  # TODO: Configure cheats in nix
  programs.navi = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      cheats.paths = [
        "~/.dotfiles/nix/modules/home/programs/navi/cheats"
      ];

      styles = {
        tag = {
          color = "cyan";
          width_percentage = 26;
          min_width = 20;
        };
        comment = {
          color = "blue";
          width_percentage = 42;
          min_width = 45;
        };
        snippet = {
          color = "white";
        };
      };

      finder.command = "fzf";
      shell.command = "zsh";
    };
  };
}
