{ ... }: {
  programs.gh = {
    enable = true;
    settings = {
      aliases = {
        po = "pr view --web"
        wr = "workflow run"
        wl = "workflow list"
        rw = "run watch"
        rl = "run view --log"
      };
    };
  };
}
