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
      v = "nvim --listen /tmp/nvimsocket";
      c = "cargo";
      dc = "docker compose";
      d = "docker";
      n = "navi";
      tf = "terraform";
      g = "git";
      la = "ls -la";
      kn = "k9s";
      kc = "kubectl";
      a = "aider --subtree-only --no-attribute-author --no-attribute-committer";
      ad = "aider --subtree-only --deepseek --no-attribute-author --no-attribute-committer";
      ac = "aider --subtree-only --sonnet --no-attribute-author --no-attribute-committer";
    };

    initExtra = ''
      setopt PROMPT_SUBST
      setopt AUTO_CD
      setopt CASE_GLOB
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
      PROMPT='%F{blue}%1~%f> '

      if command -v asdf >/dev/null; then
        . "$(dirname $(readlink -f $(which asdf)))/../share/asdf-vm/asdf.sh"
      fi

      export PATH="/Users/morganmccauley/.cargo/bin:$PATH"

      if [ -d "./node_modules/.bin" ]; then
        export PATH=$(pwd)/node_modules/.bin:$PATH
      fi

      export PATH="/opt/homebrew/bin:$PATH"

      # FIX: Feels like navi should pick this up automatically?
      export NAVI_CONFIG=$HOME/Library/Application\ Support/navi/config.yaml

      source /Users/morganmccauley/.config/op/plugins.sh
    '';
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
}
