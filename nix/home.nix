{ ... }:

{
  imports = [
    <home-manager/nix-darwin>
  ];

  users.users = {
    morganmccauley = {
      name = "morganmccauley";
      home = "/Users/morganmccauley";
    };
  };

  home-manager = {
    # this breaks things
    # useUserPackages = true;
    useGlobalPkgs = true;
    users = {
      morganmccauley = { pkgs, ... }: {
        home.stateVersion = "23.05";

        home.packages = with pkgs; [
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
          act
          hasura-cli
          # aws-vault
        ];

        home.sessionPath = [
          "$HOME/.cargo/bin"
        ];

        programs.zsh = {
          enable = true;

          autocd = true;

          enableCompletion = true;
          enableSyntaxHighlighting = true;
          enableAutosuggestions = true;

          shellAliases = {
            v = "nvim --listen /tmp/nvimsocket";
            c = "cargo";
            dc = "docker compose";
            d = "docker";
            n = "navi";
            tf = "terraform";
            g = "git";
          };

          initExtra = ''
            export PATH="/Users/morganmccauley/.cargo/bin:$PATH"

            if [ -d "./node_modules/.bin" ]; then
                export PATH=$(pwd)/node_modules/.bin:$PATH
            fi
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

        # TODO How to store cheats?
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

        programs.starship = {
          enable = true;

          enableZshIntegration = true;

          settings = {
            aws = {
              symbol = " ";
            };
            buf = {
              symbol = " ";
            };
            c = {
              symbol = " ";
            };
            conda = {
              symbol = " ";
            };
            dart = {
              symbol = " ";
            };
            directory = {
              read_only = " 󰌾";
            };
            docker_context = {
              symbol = " ";
            };
            elixir = {
              symbol = " ";
            };
            elm = {
              symbol = " ";
            };
            fossil_branch = {
              symbol = " ";
            };
            gcloud = {
              symbol = " ";
            };
            git_branch = {
              symbol = " ";
            };
            golang = {
              symbol = " ";
            };
            guix_shell = {
              symbol = " ";
            };
            haskell = {
              symbol = " ";
            };
            haxe = {
              symbol = "⌘ ";
            };
            hg_branch = {
              symbol = " ";
            };
            hostname = {
              ssh_symbol = " ";
            };
            java = {
              symbol = " ";
            };
            julia = {
              symbol = " ";
            };
            lua = {
              symbol = " ";
            };
            memory_usage = {
              symbol = "󰍛 ";
            };
            meson = {
              symbol = "󰔷 ";
            };
            nim = {
              symbol = "󰆥 ";
            };
            nix_shell = {
              symbol = " ";
            };
            nodejs = {
              symbol = " ";
            };
            os = {
              symbols = {
                Alpaquita = " ";
                Alpine = " ";
                Amazon = " ";
                Android = " ";
                Arch = " ";
                Artix = " ";
                CentOS = " ";
                Debian = " ";
                DragonFly = " ";
                Emscripten = " ";
                EndeavourOS = " ";
                Fedora = " ";
                FreeBSD = " ";
                Garuda = "󰛓 ";
                Gentoo = " ";
                HardenedBSD = "󰞌 ";
                Illumos = "󰈸 ";
                Linux = " ";
                Mabox = " ";
                Macos = " ";
                Manjaro = " ";
                Mariner = " ";
                MidnightBSD = " ";
                Mint = " ";
                NetBSD = " ";
                NixOS = " ";
                OpenBSD = "󰈺 ";
                openSUSE = " ";
                OracleLinux = "󰌷 ";
                Pop = " ";
                Raspbian = " ";
                Redhat = " ";
                RedHatEnterprise = " ";
                Redox = "󰀘 ";
                Solus = "󰠳 ";
                SUSE = " ";
                Ubuntu = " ";
                Unknown = " ";
                Windows = "󰍲 ";
              };
            };
            package = {
              symbol = "󰏗 ";
            };
            pijul_channel = {
              symbol = "🪺 ";
            };
            python = {
              symbol = " ";
            };
            rlang = {
              symbol = "󰟔 ";
            };
            ruby = {
              symbol = " ";
            };
            rust = {
              symbol = " ";
            };
            scala = {
              symbol = " ";
            };
            spack = {
              symbol = "🅢 ";
            };
          };
        };
      };
    };
  };
}
