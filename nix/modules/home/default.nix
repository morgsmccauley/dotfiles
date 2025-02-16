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
    python312Packages.playwright
  ];

  home.activation = {
    installPlaywrightDeps = {
      after = [ "writeBoundary" "linkGeneration" ];
      before = [ ];
      data = ''
        if [ ! -d "$HOME/Library/Caches/ms-playwright" ]; then
          echo "Installing Playwright dependencies..."
          ${pkgs.python312Packages.playwright}/bin/playwright install --with-deps chromium
        else
          echo "Playwright dependencies already installed, skipping..."
        fi
      '';
    };
  };

  # FIX Doesn't seem to work
  # home.sessionPath = [
  #   "$HOME/.npm-packages/bin"
  #   "/opt/homebrew/bin"
  # ];
}
