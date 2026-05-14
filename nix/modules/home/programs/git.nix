{ ... }: {
  programs.git = {
    enable = true;
    signing.format = "openpgp";

    # hooks = {
    #   post-checkout = ./git/post-checkout;
    # };

    settings = {
      user = {
        name = "Morgan Mccauley";
        email = "morgan@mccauley.co.nz";
        signingKey = "D34BEDB427EACAFA";
      };
      alias = {
        w = "worktree";
        st = "status --short";
        l = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
      };
      core = {
        editor = "nvim";
        pager = "less";
        # NOTE: Messes with starship
        # fsmonitor = true;
        # untrackedcache = true;
      };
      github = {
        user = "morgsmccauley";
      };
      init = {
        defaultBranch = "main";
      };
      push = {
        autoSetupRemote = true;
      };
      commit = {
        gpgsign = true;
      };
    };
    ignores = [
      ".aider*"
    ];
  };
}
