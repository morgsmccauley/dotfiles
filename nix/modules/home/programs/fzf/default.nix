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
  };

  home.packages = [ fzf-wrapper ];

  programs.zsh.initExtra = ''
    # Use fzf-wrapper instead of fzf directly
    alias fzf=${fzf-wrapper}/bin/fzf-wrapper
  '';
}
