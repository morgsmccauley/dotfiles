{ pkgs, ... }: {
  home.packages = [ pkgs.aider-chat ];
  # home.packages = [ pkgs.aider-chat.withPlaywright ];

  home.file.".aider.conf.yml".text = ''
    # Default model
    sonnet: true
    
    # Common settings for all models
    no-attribute-author: true
    no-attribute-committer: true
    subtree-only: true
    dark-mode: true
  '';
}
