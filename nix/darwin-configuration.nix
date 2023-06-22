{ config, pkgs, lib, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  imports = [ <home-manager/nix-darwin> ];

  users.users = {
    morganmccauley = {
      name = "morganmccauley";
      home = "/Users/morganmccauley";
    };
  };

  home-manager = {
    # useUserPackages = true;
    useGlobalPkgs = true;
    users = {
      morganmccauley = { pkgs, ... }: {
        home.stateVersion = "23.05";
        programs.zsh = {
          enable = true;

          autocd = true;

          enableCompletion = true;
          enableSyntaxHighlighting = true;

          shellAliases = {
            v = "nvim --listen /tmp/nvimsocket";
            c = "cargo";
            dc = "docker compose";
            d = "docker";
            n = "navi";
            tf = "terraform";
            g = "git";
          };
        };

        programs.zoxide = {
          enable = true;

          enableZshIntegration = true;
        };

        programs.git = {
          enable = true;

          userName = "Morgan Mccauley";
          userEmail = "morgan@mccauley.co.nz";

          aliases = {
            w = "worktree";
            st = "status --short";
            l = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
          };

          extraConfig = {
            core = {
              editor = "nvim";
              pager = "less";
            };
            github = {
              user = "morgsmccauley";
            };
            init = {
              defaultBranch = "main";
            };
          };
          ignores = [];
        };

        programs.kitty = {
          enable = true;

          settings = {
            font_family = "Hack Nerd Font Regular";
            bold_font = "Hack Nerd Font Bold";
            italic_font = "Hack Nerd Font Italic";
            bold_italic_font = "Hack Nerd Font Bold Italic";

            font_size = "13.45";

            disable_ligatures = "always";

            cursor_shape = "block";
            cursor_blink_interval = "0";

            mouse_hide_wait = "-1";

            tab_bar_edge = "top";
            tab_bar_style = "separator";
            tab_separator = " | ";

            allow_remote_control = "yes";
            listen_on = "unix:/tmp/kitty";

            shell_integration = "enabled no-cursor";

            macos_thinken_font = "0.15";
          };

          keybindings = {
            "cmd+1" = "goto_tab 1";
            "cmd+2" = "goto_tab 2";
            "cmd+3" = "goto_tab 3";
            "cmd+4" = "goto_tab 4";
            "cmd+5" = "goto_tab 5";
            "cmd+6" = "goto_tab 6";
            "cmd+7" = "goto_tab 7";
            "cmd+8" = "goto_tab 8";
            "cmd+9" = "goto_tab 9";

            "kitty_mod+t" = "no_op";
          };

          theme = "Catppuccin-Macchiato";
        };

        programs.fzf = {
          enable = true;

          defaultOptions = [
            "--layout reverse"
            "--bind ctrl-u:preview-page-up,ctrl-d:preview-page-down"
          ];

          # Catppuccin-Macchiato
          colors = {
            "bg" = "#24273a";
            "bg+" = "#24273a";
            "spinner" = "#f4dbd6";
            "hl" = "#ed8796";
            "fg" = "#cad3f5";
            "header" = "#ed8796";
            "info" = "#c6a0f6";
            "pointer" = "#f4dbd6";
            "marker" = "#f4dbd6";
            "fg+" = "#cad3f5";
            "prompt" = "#c6a0f6";
            "hl+" = "#ed8796";
          };

          # # Catppuccin-Latte
          # colors = {
          #   "bg" = "#eff1f5";
          #   "bg+" = "#eff1f5";
          #   "spinner" = "#dc8a78";
          #   "hl" = "#d20f39";
          #   "fg" = "#4c4f69";
          #   "header" = "#d20f39";
          #   "info" = "#8839ef";
          #   "pointer" = "#dc8a78";
          #   "marker" = "#dc8a78";
          #   "fg+" = "#4c4f69";
          #   "prompt" = "#8839ef";
          #   "hl+" = "#d20f39";
          # };
        };

      };
    };
  };

  environment.systemPackages = with pkgs; [
    vim
    fzf
    jq
    yq
    ripgrep
    neovim
    kitty
    navi
    zoxide
    google-cloud-sdk
    awscli2
    nodejs_18
    rustup
    monitorcontrol
    gh
    starship
    terraform
    postgresql_14
    redis
    httpie
    neovim-remote
    nodePackages.serverless
  ];

  services.yabai = {
    enable = true;
    package = pkgs.yabai;
  };

  # /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "uninstall";
    };
    taps = [
      "homebrew/cask"
    ];
    caskArgs = {
      appdir = "/Applications";
      require_sha = true;
    };
    brews = [
      # Also need to run:
      # mkdir -p ~/.docker/cli-plugins
      # ln -sfn $HOMEBREW_PREFIX/opt/docker-compose/bin/docker-compose ~/.docker/cli-plugins/docker-compose
      "docker-compose"
    ];
    casks = [
      # "monitorcontrol"
      "raycast"
      "docker"
      "obsidian"
    ];
    masApps = {
      "Shortery" = 1594183810;
      "Slack" = 803453959;
    };
  };

  services.karabiner-elements.enable = true;

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh = {
    enable = true;
    enableSyntaxHighlighting = true;
    enableFzfHistory = true;
    enableFzfCompletion = true;
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  system.defaults.NSGlobalDomain.InitialKeyRepeat = 10;
  system.defaults.NSGlobalDomain.KeyRepeat = 1;
  system.defaults.NSGlobalDomain._HIHideMenuBar = true;

  system.defaults.trackpad.TrackpadThreeFingerDrag = true;
  system.defaults.trackpad.Clicking = true;
  system.defaults.trackpad.ActuationStrength = 0;

  system.defaults.dock.autohide = true;
  system.defaults.dock.show-process-indicators = true;
  system.defaults.dock.show-recents = true;
  system.defaults.dock.static-only = true;
  system.defaults.dock.mru-spaces = false;

  system.defaults.finder.ShowPathbar = true;
  system.defaults.finder.AppleShowAllFiles = true;

  system.defaults.loginwindow.GuestEnabled = false;

  system.defaults.LaunchServices.LSQuarantine = false;

  # system.defaults.CustomUserPreferences = {
  #   "com.apple.Dock" = {
  #     "static-others" = ''<array><dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>file:///Users/morganmccauley/Downloads/</string><key>_CFURLStringType</key><integer>15</integer></dict><key>file-type</key><integer>2</integer><key>showas</key><integer>2</integer><key>displayas</key><integer>1</integer><key>file-label</key><string>Downloads</string><key>url</key><string>file:///Users/morganmccauley/Downloads/</string></dict><key>tile-type</key><string>directory-tile</string></dict><dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>file:///Applications/</string><key>_CFURLStringType</key><integer>15</integer></dict><key>file-type</key><integer>2</integer><key>showas</key><integer>2</integer><key>displayas</key><integer>1</integer><key>file-label</key><string>Applications</string><key>url</key><string>file:///Applications/</string></dict><key>tile-type</key><string>directory-tile</string></dict><dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>file:///Users/morganmccauley/Documents/</string><key>_CFURLStringType</key><integer>15</integer></dict><key>file-type</key><integer>2</integer><key>showas</key><integer>2</integer><key>displayas</key><integer>1</integer><key>file-label</key><string>Documents</string><key>url</key><string>file:///Users/morganmccauley/Documents/</string></dict><key>tile-type</key><string>directory-tile</string></dict><dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>file:///Users/morganmccauley/Developer/</string><key>_CFURLStringType</key><integer>15</integer></dict><key>file-type</key><integer>2</integer><key>showas</key><integer>2</integer><key>displayas</key><integer>1</integer><key>file-label</key><string>Developer</string><key>url</key><string>file:///Users/morganmccauley/Developer/</string></dict><key>tile-type</key><string>directory-tile</string></dict></array>'';
  #   };
  # };
}
