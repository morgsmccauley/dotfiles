{ pkgs, ... }: {
  imports = [
    ./programs/git.nix
    ./programs/zsh.nix
    ./programs/kitty.nix
    ./programs/fzf.nix
    ./programs/navi.nix
    ./programs/starship.nix
  ];

  home.stateVersion = "24.05";
  home.packages = with pkgs; [
    jq
    ripgrep
    rustup
    monitorcontrol
    httpie
    efm-langserver
    lua-language-server
    typescript-language-server
    vscode-langservers-extracted
    vscode-js-debug
  ];
  # FIX Doesn't seem to work
  # home.sessionPath = [
  #   "$HOME/.npm-packages/bin"
  #   "/opt/homebrew/bin"
  # ];
}
