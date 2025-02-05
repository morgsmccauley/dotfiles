{ ... }: {
  home.file.".aider.conf.yml".text = ''
    # Default model
    model: gpt-4-1106-preview
    
    # Common settings for all models
    no-attribute-author: true
    no-attribute-committer: true
    subtree-only: true

    # Model-specific configurations
    models:
      gpt-4-1106-preview: {}
      deepseek-coder: {}
      claude-3-sonnet: {}
  '';
}
