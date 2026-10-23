{ pkgs, ... }:
{
    boot = {
	    # Use the systemd-boot EFI boot loader:
    	loader.systemd-boot.enable = true;
		loader.efi.canTouchEfiVariables = true;

	    # Use latest kernel:
	    # boot.kernelPackages = pkgs.linuxPackages_latest;
	    kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;

	    # Use a cool NixOS logo instead of the systemd messages:
	    plymouth = {
	        # Enables boot.kernelParams[*] = "splash":
	        enable = true;
	        # Cool stars:
	        theme = "fade-in";
	    };

	    # Enable "silent boot" (still can see logs by pressing 'esc'):
	    consoleLogLevel = 3;
	    initrd.verbose = false;
	    loader.timeout = 0;
	    kernelParams = [
	        "quiet"
	        "loglevel=3"
	        # Hide the OS choice for bootloaders.
	        # It's still possible to open the bootloader list by pressing any key,
	        # it will just not appear on screen unless a key is pressed.
	        "systemd.show_status=auto"
	        "rd.udev.log_level=3"
	        "rd.systemd.show_status=auto"
	    ];
    };
}
