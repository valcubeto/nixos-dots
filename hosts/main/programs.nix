{ pkgs, ... }:
{
    environment.systemPackages = with pkgs; [
        home-manager

        # System:
        btop
        brightnessctl
        nixos-icons
        wl-clipboard

        # Graphics:
        egl-wayland

        gcc
        binutils

        # Terminal tools:
        microfetch
        fzf
        fd
        ripgrep
        tree
        eza

        # Internet tools:
        wget
        curl
        gh

        # Terminals:
        # alacritty
        kitty

        # Programming languages:
        python314
        bun
        rustup
        # Nix LSP:
        nixd
        # rust-analyzer

        # Text editors:
        zed
        micro

        # Desktop environment:
        hyprcursor
        # waybar
    ];

    # A few programs have a dedicated configuration module:
    programs = {
        # Enable to allow dynamically-linked programs to run (i.e. Zed's rust-analyzer)
        nix-ld = {
            enable = true;
        };
        # Enabled by default:
        nano.enable = false;
        # firefox.enable = true;
        hyprland = {
            enable = true;
            xwayland.enable = true;
        };
        niri = {
        	enable = true;
        };
        fish = {
            enable = true;
        };
        bash = {
            enable = true;
            promptInit = ''
              export PS1="\e[4;32m\u\e[39;24m@\e[4;32m\h\e[39;24m \e[36m\w\e[39m \$ "
            '';
            shellAliases = {
                "ls" = "eza --icons=auto --all --sort=type --git-ignore";
            };
            interactiveShellInit = ''
                if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" ]] && [[ -z "$BASH_EXECUTION_STRING" ]]; then
                  shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
                  exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
                fi
            '';
        };
        zoxide = {
            enable = true;
            # Execute 'zoxide init fish':
            enableFishIntegration = true;
            # Execute 'zoxide init bash':
            enableBashIntegration = true;
            # Alias 'cd' to 'z':
            flags = [ "--cmd=cd" ];
        };
        git = {
            enable = true;
            config = {
                user.name = "Cubeto";
                user.email = "valcubeto@proton.me";
                init.defaultBranch = "main";
                core.editor = "micro";
                safe.directory = "/etc/nixos";
                # pull.rebase = true;
                # fetch.prune = true;
            };
        };
        gamemode.enable = true;
        steam = {
            package = pkgs.unstable.steam;
            enable = true;
            # Open ports in the firewall for Steam Remote Play:
            remotePlay.openFirewall = true;
              # Open ports for Source Dedicated Server hosting:
              dedicatedServer.openFirewall = true;
        };
    };

    # Some programs need SUID wrappers, can be configured further or are started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #     enable = true;
    #     enableSSHSupport = true;
    # };

    fonts = {
        packages = with pkgs; [
            nerd-fonts.jetbrains-mono
        ];
    };
}
