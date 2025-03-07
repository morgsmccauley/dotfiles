{ ... }: {
  services.aerospace = {
    enable = true;
    settings = {
      enable-normalization-flatten-containers = true;
      enable-normalization-opposite-orientation-for-nested-containers = true;
      accordion-padding = 0;
      default-root-container-layout = "tiles";
      default-root-container-orientation = "auto";
      key-mapping.preset = "qwerty";
      on-focused-monitor-changed = ["move-mouse monitor-lazy-center"];

      gaps = {
        inner.horizontal = 25;
        inner.vertical = 25;
        outer.left = 25;
        outer.bottom = 25;
        outer.top = 25;
        outer.right = 25;
      };

      mode.main.binding = {
        alt-slash = "layout tiles accordion";
        alt-h = "focus left";
        alt-j = "focus down";
        alt-k = "focus up";
        alt-l = "focus right";
        alt-shift-h = "move left";
        alt-shift-j = "move down";
        alt-shift-k = "move up";
        alt-shift-l = "move right";
        alt-shift-minus = "resize smart -100";
        alt-shift-equal = "resize smart +100";
        alt-1 = "workspace 1-code";
        alt-2 = "workspace 2-tools";
        alt-3 = "workspace 3-chat";
        alt-4 = "workspace 4-mail";
        alt-shift-1 = "move-node-to-workspace 1-code";
        alt-shift-2 = "move-node-to-workspace 2-tools";
        alt-shift-3 = "move-node-to-workspace 3-chat";
        alt-shift-4 = "move-node-to-workspace 4-mail";
        alt-tab = "workspace-back-and-forth";
        alt-shift-tab = "move-workspace-to-monitor --wrap-around next";
        alt-0 = "balance-sizes";
        alt-minus = "resize smart -50";
        alt-equal = "resize smart +50";
        alt-left = ["join-with left" "layout accordion"]; # Merge with left window (cursor/kitty)
        alt-right = ["join-with right" "layout accordion"];
      };

      # is it possible to stack cursor/kitty so that I can have both act as 1?
      on-window-detected = [
        {
          "if".app-name-regex-substring = "notes|finder|messages";
          run = "layout floating";
        }
        {
          "if".app-name-regex-substring = "brave|kitty|cursor";
          run = "move-node-to-workspace 1-code";
        }
        {
          "if".app-name-regex-substring = "dbeaver|postman";
          run = "move-node-to-workspace 2-tools";
        }
        {
          "if".app-name-regex-substring = "slack|discord|telegram";
          run = "move-node-to-workspace 3-chat";
        }
        {
          "if".app-name-regex-substring = "mail|calendar";
          run = "move-node-to-workspace 4-mail";
        }
        # {
        #   "if".app-name-regex-substring = "cursor";
        #   run = "join-with kitty"
        # }
      ];
    };
  };
}
