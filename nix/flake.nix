{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager }:
  let
    configuration = { pkgs, config, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [
          pkgs.neovim
        ];

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
            inner.vertical =   25;
            outer.left =       25;
            outer.bottom =     25;
            outer.top =        25;
            outer.right =      25;
          };

          mode.main.binding = {
            alt-slash = "layout tiles horizontal accordion horizontal";

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

            alt-1 = "workspace 1";
            alt-2 = "workspace 2";
            alt-3 = "workspace 3";
            alt-4 = "workspace 4";
            alt-5 = "workspace 5";

            alt-shift-1 = "move-node-to-workspace 1";
            alt-shift-2 = "move-node-to-workspace 2";
            alt-shift-3 = "move-node-to-workspace 3";
            alt-shift-4 = "move-node-to-workspace 4";
            alt-shift-5 = "move-node-to-workspace 5";

            alt-tab = "workspace-back-and-forth";
            alt-shift-tab = "move-workspace-to-monitor --wrap-around next";

            alt-shift-semicolon = "mode service";

            alt-equal = "balance-sizes";
          };

          # FIX: nix-darwin expects wrong type (https://github.com/LnL7/nix-darwin/issues/1142)
          on-window-detected = [ ];

          # # Sender Wallet
          # [[on-window-detected]]
          # if.window-title-regex-substring = '^chrome-extension://epapihdplajcdnnkdeiahlgigofloibg'
          # run = 'layout floating'
          #
          # [[on-window-detected]]
          # if.app-id = 'com.apple.finder'
          # run = 'layout floating'
          #
          # [[on-window-detected]]
          # if.app-id = 'com.apple.MobileSMS'
          # run = 'layout floating'
          #
          # # [[on-window-detected]]
          # # if.app-id = 'com.apple.Notes'
          # # run = 'layout floating'
          #
          # [[on-window-detected]]
          # if.app-id = 'com.apple.Home'
          # run = 'layout floating'
        };
      };

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      users.users = {
        morganmccauley = {
          name = "morganmccauley";
          home = "/Users/morganmccauley";
        };
      };

      security.pam.enableSudoTouchIdAuth = true;

      homebrew = {
        enable = true;
        onActivation = {
          cleanup = "uninstall";
        };
        taps = [
          "homebrew/services"
        ];
        caskArgs = {
          appdir = "/Applications";
          require_sha = true;
        };
        brews = [ ];
        casks = [
          "raycast"
          "docker"
          "1password-cli"
          "1password"
          "karabiner-elements"
        ];
        masApps = {
          "Shortery" = 1594183810;
          "Slack" = 803453959;
        };
      };

      system.activationScripts.preUserActivation.text = ''
        if ! command -v ${config.homebrew.brewPrefix}/brew &> /dev/null; then
          echo "Installing brew"
          /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi
      '';

      # FIX: conflicts with duplicate script below
      # system.activationScripts.postUserActivation.text = ''
      #   if [ ! -L ~/.docker/cli-plugins/docker-compose ]; then
      #       echo "Linking compose plugin to docker CLI"
      #
      #       mkdir -p ~/.docker/cli-plugins
      #       ln -sfn ${config.homebrew.brewPrefix}/docker-compose ~/.docker/cli-plugins/docker-compose
      #   fi
      # '';

      system.defaults = {
        NSGlobalDomain = {
          InitialKeyRepeat = 10;
          KeyRepeat = 1;
          _HIHideMenuBar = true;
        };

        trackpad = {
          TrackpadThreeFingerDrag = true;
          Clicking = true;
          ActuationStrength = 0;
        };

        dock = {
          autohide = true;
          show-process-indicators = true;
          show-recents = true;
          static-only = true;
          mru-spaces = false;
        };

        finder = {
          ShowPathbar = true;
          AppleShowAllFiles = true;
          AppleShowAllExtensions = true;
          FXPreferredViewStyle = "clmv";
        };

        loginwindow = {
          GuestEnabled = false;
        };

        LaunchServices = {
          LSQuarantine = false;
        };
      };

      system.activationScripts.postUserActivation.text = ''
        # Avoid a logout/login cycle
        /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
        '';

          # Used for backwards compatibility, please read the changelog before changing.
          # $ darwin-rebuild changelog
          system.stateVersion = 5;

          # The platform the configuration will be used on.
          nixpkgs.hostPlatform = "aarch64-darwin";
        };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple
    darwinConfigurations."Morgans-MacBook-Pro" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
        # TODO: Split in to separate file
        home-manager.darwinModules.home-manager
        {
          home-manager = {
            # this breaks things?
            useUserPackages = true;
            useGlobalPkgs = true;
            users = {
              morganmccauley = { pkgs, ... }: {
                home.stateVersion = "24.05";
                home.packages = with pkgs; [
                  jq
                  ripgrep
                  rustup
                  monitorcontrol
                  httpie
                ];

                programs.zsh = {
                  enable = true;

                  autocd = true;

                  enableCompletion = true;
                  syntaxHighlighting = {
                    enable = true;
                  };
                  autosuggestion = {
                    enable = true;
                  };

                  # FIX: Not being picked up by shell
                  sessionVariables = {
                    EDITOR = "nvim";
                  };

                  shellAliases = {
                    v = "nvim --listen /tmp/nvimsocket";
                    c = "cargo";
                    dc = "docker compose";
                    d = "docker";
                    n = "navi";
                    tf = "terraform";
                    g = "git";
                    la = "ls -la";
                  };

                  # plugins = [
                  #   {
                  #     name = "fzf-tab";
                  #     src = "${pkgs.zsh-fzf-tab}/share/fzf-tab";
                  #   }
                  # ];

                  initExtra = ''
                    export PATH="/Users/morganmccauley/.cargo/bin:$PATH"

                    if [ -d "./node_modules/.bin" ]; then
                      export PATH=$(pwd)/node_modules/.bin:$PATH
                    fi

                    export PATH="/opt/homebrew/bin:$PATH"
                  '';
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
                      # messes with starship
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
                  ignores = [];
                };

                # TODO: How to store cheats?
                # TODO: dotfile not being stored/linked
                programs.navi = {
                  enable = true;

                  enableZshIntegration = true;

                  settings = {
                    cheats = {
                      paths = [
                        "~/.dotfiles/navi/cheats/"
                      ];
                    };

                    styles = {
                      tag = {
                        color = "cyan";
                        width_percentage = 26;
                        min_width = 20;
                      };
                      comment = {
                        color = "blue";
                        width_percentage = 42;
                        min_width = 45;
                      };
                      snippet = {
                        color = "white";
                      };
                    };

                    finder = {
                      command = "fzf";
                    };

                    shell = {
                      command = "zsh";
                    };
                  };
                };

                programs.kitty = {
                  enable = true;

                  # NOTE: Override to prevent build issues with the latest version in nixpkgs-unstable.
                  package = pkgs.kitty.overrideAttrs (oldAttrs: {
                    version = "0.38.1";
                    src = pkgs.fetchFromGitHub {
                      owner = "kovidgoyal";
                      repo = "kitty";
                      rev = "v0.38.1";
                      hash = "sha256-0M4Bvhh3j9vPedE/d+8zaiZdET4mXcrSNUgLllhaPJw=";
                    };
                  });

                  settings = {
                    font_family = "Hack Nerd Font Regular";
                    bold_font = "Hack Nerd Font Bold";
                    italic_font = "Hack Nerd Font Italic";
                    bold_italic_font = "Hack Nerd Font Bold Italic";

                    font_size = "13";

                    disable_ligatures = "always";

                    cursor_shape = "underline";
                    cursor_blink_interval = "0";

                    mouse_hide_wait = "-1";

                    tab_bar_edge = "top";
                    tab_bar_style = "separator";
                    tab_separator = " | ";

                    allow_remote_control = "yes";
                    listen_on = "unix:/tmp/kitty";

                    shell_integration = "enabled no-cursor";

                    macos_thinken_font = "0.25";
                  };

                  extraConfig = ''
                  enabled_layouts stack
                  '';

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

                  themeFile = "Catppuccin-Latte";
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

                programs.starship = {
                  enable = true;

                  enableZshIntegration = true;
                };
              };
            };
          };
        }
      ];
    };
  };
}
