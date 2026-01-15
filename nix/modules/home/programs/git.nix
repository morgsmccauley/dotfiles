{ ... }: {
  programs.git = {
    enable = true;

    userName = "Morgan Mccauley";
    userEmail = "morgan@mccauley.co.nz";

    aliases = {
      w = "worktree";
      st = "status --short";
      l = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
    };

    settings = {
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
    };
    ignores = [
      ".aider*"
    ];
  };
}
