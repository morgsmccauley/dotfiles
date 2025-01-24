#!/usr/bin/env bash

# Get the current system appearance (dark/light)
if defaults read -g AppleInterfaceStyle &> /dev/null; then
    THEME="dark"
else
    THEME="light"
fi

# Set FZF_DEFAULT_OPTS based on theme
if [ "$THEME" = "dark" ]; then
    export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
      --color=bg:#1e1e2e,bg+:#313244,spinner:#f5e0dc,hl:#f38ba8 \
      --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
      --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
      --color=selected-bg:#45475a"
else
    export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
      --color=bg:#eff1f5,bg+:#eff1f5,spinner:#dc8a78,hl:#d20f39 \
      --color=fg:#4c4f69,header:#d20f39,info:#8839ef,pointer:#dc8a78 \
      --color=marker:#dc8a78,fg+:#4c4f69,prompt:#8839ef,hl+:#d20f39"
fi

# Execute fzf with all arguments passed to this script
exec fzf "$@"
