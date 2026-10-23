{ inputs, ... }:
{
    imports = [
        ./boot.nix
        ./hardware/hardware-configuration.nix
        ./network/default.nix
        ./programs.nix
        ./security.nix
        ./services.nix
        ./users.nix
    ];

    nix = {
	    settings = {
	    	experimental-features = [ "nix-command" "flakes" ];
	    	auto-optimise-store = true;
	    	warn-dirty = false;
	    	bash-prompt-prefix = "(nix-shell) ";
	    	# Default is undefinitely:
	    	connect-timeout = 10;
	    	# Maximum overdrive:
	    	cores = 0;
	    	max-jobs = "auto";
	    	# Default is 5:
	    	download-attempts = 3;
	    	# WARNING: "true" improves robustness in case of system crashes, but reduces performance:
	    	fsync-metadata = false;
	    	show-trace = true;
	    };
	    nixPath = [
	    	"nixpkgs=${inputs.nixpkgs}"
	    	"nixpkgs-unstable=${inputs.nixpkgs-unstable}"
	    ];
	};

    time.timeZone = "America/Buenos_Aires";

    # Select internationalisation properties.
    # i18n.defaultLocale = "en_US.UTF-8";
    # console = {
    #     font = "Lat2-Terminus16";
    #     keyMap = "us";
    #     useXkbConfig = true; # use xkb.options in tty.
    # };

    # 'hardware-configuration.nix' tells me to use this file instead. Do I really need it?


    # Avoid using both at the same time!
    # swapDevices = [ { device = "/swap/swapfile"; } ];
    systemd.services.zswap.enable = false;
    zramSwap = {
        enable = true;
        # algorithm = "zstd";
        # memoryPercent = 30;
        # priority = 10;
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
    # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion.
    system.stateVersion = "26.05"; # Did you read the comment?
}
