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
      export PATH="/Users/morganmccauley/.dotfiles/scripts:$PATH"
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
      cl = "claude";
      cx = "codex";
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

      autoload -U edit-command-line
      zle -N edit-command-line
      autoload -Uz add-zsh-hook

      export EDITOR=edit_in_parent_nvim

      bindkey '^u' edit-command-line

      typeset -g NOTIF_LAST_CMD=""
      typeset -gi NOTIF_LAST_START=0

      _notif_preexec() {
        NOTIF_LAST_CMD="$1"
        NOTIF_LAST_START=$SECONDS
      }

      notif() {
        emulate -L zsh
        setopt extended_glob

        local raw_cmd cmd cwd title subtitle message elapsed
        cwd="''${PWD/#$HOME/~}"
        raw_cmd="''${NOTIF_LAST_CMD:-$(fc -ln -1 2>/dev/null)}"
        cmd=$(print -r -- "$raw_cmd" | sed -E 's/[[:space:]]*(&&|;)[[:space:]]*notif([[:space:]].*)?$//')

        if [[ -z "$cmd" ]]; then
          cmd="command"
        fi

        elapsed=""
        if (( NOTIF_LAST_START > 0 )); then
          elapsed="$(( SECONDS - NOTIF_LAST_START ))s"
        fi

        title="job done"
        subtitle="$cwd"
        if [[ -n "$elapsed" ]]; then
          subtitle="$subtitle in $elapsed"
        fi

        if [[ $# -gt 0 ]]; then
          message="$*"
        else
          message="$cmd"
        fi

        NOTIF_TITLE="$title" \
        NOTIF_SUBTITLE="$subtitle" \
        NOTIF_MESSAGE="$message" \
          osascript -e 'display notification (system attribute "NOTIF_MESSAGE") with title (system attribute "NOTIF_TITLE") subtitle (system attribute "NOTIF_SUBTITLE")'
      }

      add-zsh-hook preexec _notif_preexec

      export GPG_TTY=$(tty)
      export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
    '';
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
}
