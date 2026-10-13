# Cubeto's modern NixOS with Hyprland.
# Yes, I like 4-space indents.
{ config, lib, pkgs, inputs, ... }:
{
    imports = [
        ./hardware-configuration.nix
    ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" "nixpkgs-unstable=${inputs.nixpkgs-unstable}" ];

    # Use the systemd-boot EFI boot loader:
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # Use latest kernel:
    boot.kernelPackages = pkgs.linuxPackages_latest;

    # Use a cool NixOS logo instead of the systemd messages:
    boot.plymouth = {
        # Enables boot.kernelParams[*] = "splash":
        enable = true;
        # Cool stars:
        theme = "fade-in";
    };

    # Enable "silent boot" (still can see logs by pressing 'esc'):
    boot.consoleLogLevel = 3;
    boot.initrd.verbose = false;
    boot.loader.timeout = 0;
    boot.kernelParams = [
        "quiet"
        "loglevel=3"
        # Hide the OS choice for bootloaders.
        # It's still possible to open the bootloader list by pressing any key,
        # it will just not appear on screen unless a key is pressed.
        "systemd.show_status=auto"
        "rd.udev.log_level=3"
        "rd.systemd.show_status=auto"
    ];

    # Set your time zone:
    time.timeZone = "America/Buenos_Aires";

    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Select internationalisation properties.
    # i18n.defaultLocale = "en_US.UTF-8";
    # console = {
    #     font = "Lat2-Terminus16";
    #     keyMap = "us";
    #     useXkbConfig = true; # use xkb.options in tty.
    # };

    # 'hardware-configuration.nix' tells me to use this file instead. Do I really need it?
    fileSystems = {
        "/".options         = [ "compress=zstd" "noatime" ];
        "/home".options = [ "compress=zstd" "noatime" ];
        "/nix".options    = [ "compress=zstd" "noatime" ];
    };

    # Avoid using both at the same time!
    # swapDevices = [ { device = "/swap/swapfile"; } ];
    systemd.services.zswap.enable = false;
    zramSwap = {
        enable = true;
        # algorithm = "zstd";
        # memoryPercent = 30;
        # priority = 10;
    };




    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.cubeto = {
        isNormalUser = true;
        # Enable ‘sudo’ for the user:
        extraGroups = [ "wheel" "networkmanager" ];
        packages = with pkgs; [
            tree
        ];
        shell = pkgs.bash;
    };



    # -- SERVICES --

    # Enable touchpad support (enabled default in most desktopManager):
    # services.libinput.enable = true;

    # Auto-login in the kernel console:
    services = {
    	getty.autologinUser = "cubeto";
	    openssh.enable = true;

	    # To enable power saver/performance modes:
	    power-profiles-daemon.enable = true;

	    # Auto-start Hyprland on boot:
	    greetd = {
	        enable = true;
	        settings.default_session = {
	            user = "cubeto";
	            command = "start-hyprland";
	        };
	    };

	    # Enable an alternative Kernel Mode Settings Console:
	    kmscon = {
	        enable = false;
	        term = "xterm-256color";
	        hwRender = true;
	        fonts = [
	            {
	                name = "JetBrainsMono Nerd Font";
	                package = pkgs.nerd-fonts.jetbrains-mono;
	            }
	        ];
	    };

	    # Enable sound:
		pipewire = {
	        enable = true;
	        # Enable PulseAudio retro compatibility:
	        pulse.enable = true;
	    };
	};

    networking.hostName = "nixos";
    # Configure network connections interactively with nmcli or nmtui:
    networking.networkmanager.enable = true;
    # Open ports in the firewall:
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    networking.firewall.enable = false;



    # -- PROGRAMS --
    environment.systemPackages = with pkgs; [
    	# System:
        btop
        brightnessctl
        rust-motd
        nixos-icons
        wl-clipboard

		gcc
		binutils

		# Terminal tools:
        microfetch
        fzf
        fd
        ripgrep
        eza

        # Internet tools:
        wget
        curl
        gh
        unstable.brave-origin

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
        # waybar
    ];

    # A few programs have a dedicated configuration module:
    programs = {
    	# Enabled by default:
        nano.enable = false;
        # firefox.enable = true;
	    hyprland = {
	        enable = true;
	        xwayland.enable = false;
	    };
	    fish = {
	        enable = true;
	    };
	    bash = {
	        enable = true;
	        shellAliases = {
	        	"ls" = "eza --icons=auto --all --sort=type";
	        };
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
	        # This goes in home.nix
	        # settings = {
	        # 	user = {
	        # 		name = "Cubeto";
	        # 		email = "valcubeto@proton.me";
	        # 	};
	        # };
	        config = {
	            user.name = "Cubeto";
	            user.email = "valcubeto@proton.me";
	            init.defaultBranch = "main";
	            core.editor = "micro";
	            # pull.rebase = true;
	            # fetch.prune = true;
            };
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



    # -- SYSTEM --
    # Copy the NixOS configuration file and link it from the resulting system
    # (/run/current-system/configuration.nix). This is useful in case you
    # accidentally delete configuration.nix.
    # NOT ALLOWED USING FLAKES.
    # system.copySystemConfiguration = true;

    # README:
    # This option defines the first version of NixOS you have installed on this particular machine,
    # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
    #
    # Most users should NEVER change this value after the initial install, for any reason,
    # even if you've upgraded your system to a new NixOS release.
    #
    # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
    # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
    # to actually do that.
    #
    # This value being lower than the current NixOS release does NOT mean your system is
    # out of date, out of support, or vulnerable.
    #
    # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
    # and migrated your data accordingly.
    #
    # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
    system.stateVersion = "26.05"; # Did you read the comment?
}
