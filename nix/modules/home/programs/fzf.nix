{ config, pkgs, lib, ... }:

let
  fzf-wrapper = pkgs.writeScriptBin "fzf-wrapper" (builtins.readFile ./fzf-wrapper.sh);
in
{
  programs.fzf = {
    enable = true;

    defaultOptions = [
      "--layout reverse"
      "--bind ctrl-u:preview-page-up,ctrl-d:preview-page-down"
    ];

    # AI! Fix this so the c-r command uses fzf wrapper, these define the input commands e.g. fd
    # defaultCommand = "${fzf-wrapper}/bin/fzf-wrapper";
    # fileWidgetCommand = "${fzf-wrapper}/bin/fzf-wrapper";
    # changeDirWidgetCommand = "${fzf-wrapper}/bin/fzf-wrapper";
  };

  home.packages = [ fzf-wrapper ];

  programs.zsh.initExtra = ''
    # Use fzf-wrapper instead of fzf directly
    alias fzf=${fzf-wrapper}/bin/fzf-wrapper
  '';
}
