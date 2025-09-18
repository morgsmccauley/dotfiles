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

    initExtra = ''
      setopt PROMPT_SUBST
      setopt AUTO_CD
      setopt CASE_GLOB
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
      PROMPT='%F{blue}%1~%f> '

      if [ -d "./node_modules/.bin" ]; then
        export PATH=$(pwd)/node_modules/.bin:$PATH
      fi

      export PROTOC=${pkgs.protobuf_25}/bin/protoc

      export PATH="/Users/morganmccauley/.cargo/bin:$PATH"
      export PATH="/opt/homebrew/bin:$PATH"

      # FIX: Feels like navi should pick this up automatically?
      export NAVI_CONFIG=$HOME/Library/Application\ Support/navi/config.yaml

      source /Users/morganmccauley/.config/op/plugins.sh

      edit_in_parent_nvim() {
          local file="''${@: -1}"
          nvr -cc "rightbelow split" --remote-wait +'set bufhidden=delete | set wrap | set autowriteall' "$file"
      }

      autoload -U edit-command-line
      zle -N edit-command-line

      export EDITOR=edit_in_parent_nvim

      bindkey '^u' edit-command-line

      export _ZO_ECHO='1'
    '';
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
}
