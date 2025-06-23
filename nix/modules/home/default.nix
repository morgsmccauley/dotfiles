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
    tokio-console
    neovim
    # should be using 23
    protobuf_24
    websocat
    stats
    claude-code
    lsyncd
    rsync
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

  # launchd.agents.file-sync = {
  #   enable = true;
  #   config = {
  #     ProgramArguments = [ "/Users/morganmccauley/.dotfiles/scripts/sync.sh" ];
  #     WorkingDirectory = "/Users/morganmccauley/Developer";
  #     EnvironmentVariables = {
  #       FSWATCH_BIN = "${pkgs.fswatch}/bin/fswatch";
  #       RSYNC_BIN = "${pkgs.rsync}/bin/rsync";
  #       REMOTE_HOST = "morgs@dev-morgan";
  #       REMOTE_PATH = "/home/morgs/repos/";
  #       DEBOUNCE_TIME = "1";
  #       FSWATCH_LATENCY = "1";
  #       EXCLUDE_FILE = ".rsync-exclude";
  #     };
  #     StandardOutPath = "/tmp/file-sync.log";
  #     StandardErrorPath = "/tmp/file-sync.log";
  #     RunAtLoad = true;
  #     KeepAlive = false;
  #     Label = "com.user.file-sync";
  #   };
  # };

  # FIX Doesn't seem to work
  # home.sessionPath = [
  #   "$HOME/.npm-packages/bin"
  #   "/opt/homebrew/bin"
  # ];
}
