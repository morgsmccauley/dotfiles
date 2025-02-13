{ pkgs, ... }: {
  imports = [
    ./programs/git.nix
    ./programs/zsh.nix
    ./programs/gh.nix
    ./programs/aider.nix

    ./programs/fzf
    ./programs/navi
    ./programs/kitty
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
    nodejs_22
    nodePackages.prettier
    nodePackages.aws-cdk
    asdf-vm
    protoc-gen-go
    go
    grpcui
    jq
    yq
    fswatch
    aws-sam-cli
    awscli2
    lldb
    postgresql
    kubectl
    k9s
    minikube
    kubernetes-helm
    skopeo
    yaml-language-server
    grpcurl
    git-absorb
    neovim-remote
  ];
  # FIX Doesn't seem to work
  # home.sessionPath = [
  #   "$HOME/.npm-packages/bin"
  #   "/opt/homebrew/bin"
  # ];
}
