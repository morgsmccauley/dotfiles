{ pkgs, ... }: {
  programs.zsh = {
    enable = true;
    autocd = true;
    enableCompletion = true;

    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;

    # FIX: doesn't seem to get set
    sessionVariables = {
      EDITOR = "nvim";
    };

    # envExtra goes into .zshenv - sourced by ALL shells (login, interactive, non-interactive)
    # This ensures nvim launched from kitty can find LSPs, formatters, and other tools
    envExtra = ''
      export PATH="/Users/morganmccauley/.cargo/bin:$PATH"
      export PATH="/opt/homebrew/bin:$PATH"
      export PATH="/opt/homebrew/opt/ansible@10/bin:$PATH"

      # Ensure rustc knows where clang is
      export LIBCLANG_PATH="/opt/homebrew/opt/llvm/lib"
      export DYLD_LIBRARY_PATH="/opt/homebrew/opt/llvm/lib:$DYLD_LIBRARY_PATH"

      export PROTOC=${pkgs.protobuf_25}/bin/protoc

      # FIX: Feels like navi should pick this up automatically?
      export NAVI_CONFIG=$HOME/Library/Application\ Support/navi/config.yaml

      export _ZO_ECHO='1'  # Print directory path after zoxide jump
    '';

    plugins = [
      {
        name = "fzf-tab";
        src = "${pkgs.zsh-fzf-tab}/share/fzf-tab";
      }
    ];

    shellAliases = {
      v = "nvim";
      c = "cargo";
      dc = "docker compose";
      d = "docker";
      n = "navi";
      tf = "terraform";
      g = "git";
      la = "ls -la";
      kn = "k9s";
      kc = "kubectl";
      a = "aider";
      ad = "aider --model deepseek-coder";
      cl = "claude";
      clp = "claude --print";
      # TODO: set git config remote.origin.fetch '+refs/heads/*:refs/remotes/origin/*'
      gcb = "f() { local repo_name=$(basename \"$1\" .git); mkdir -p \"$repo_name\" && cd \"$repo_name\" && git clone --bare \"$1\" .git && git worktree add \"$repo_name-main\" main 2>/dev/null || git worktree add \"$repo_name-main\" master && git worktree add \"$repo_name-develop\" develop 2>/dev/null || true && git worktree add \"$repo_name-review\" && git worktree add \"$repo_name-scratch\"; }; f";
    };

    initContent = ''
      setopt PROMPT_SUBST
      setopt AUTO_CD
      setopt CASE_GLOB
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
      PROMPT='%F{blue}%1~%f> '

      if [ -d "./node_modules/.bin" ]; then
        export PATH=$(pwd)/node_modules/.bin:$PATH
      fi

      source /Users/morganmccauley/.config/op/plugins.sh

      edit_in_parent_nvim() {
          local file="''${@: -1}"
          nvr -cc "rightbelow split" --remote-wait +'set bufhidden=delete | set wrap | set autowriteall' "$file"
      }

      autoload -U edit-command-line
      zle -N edit-command-line

      export EDITOR=edit_in_parent_nvim

      bindkey '^u' edit-command-line
    '';
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
}
