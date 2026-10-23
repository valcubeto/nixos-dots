{ config, lib, modulesPath, system, ... }:
{
    imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
        ./nvidia.nix
    ];

    boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod" "alcor" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-intel" ];
    boot.extraModulePackages = [ ];

    fileSystems = {
    	"/" = {
	        device = "/dev/disk/by-uuid/a461a7b1-ff20-4b53-b9fc-c36749f345ca";
	        fsType = "btrfs";
	        options = [ "subvol=root" "compress=zstd" "noatime" ];
	    };

	    "/boot" = {
	        device = "/dev/disk/by-uuid/2362-65C4";
	        fsType = "vfat";
	        options = [ "fmask=0022" "dmask=0022" ];
	    };

	    "/home" = {
	        device = "/dev/disk/by-uuid/a461a7b1-ff20-4b53-b9fc-c36749f345ca";
	        fsType = "btrfs";
	        options = [ "subvol=home" "compress=zstd" "noatime" ];
	    };

	    "/nix" = {
	        device = "/dev/disk/by-uuid/a461a7b1-ff20-4b53-b9fc-c36749f345ca";
	        fsType = "btrfs";
	        options = [ "subvol=nix" "compress=zstd" "noatime" ];
	    };
	};

    # fileSystems."/swap" = {
    #         device = "/dev/disk/by-uuid/a461a7b1-ff20-4b53-b9fc-c36749f345ca";
    #     fsType = "btrfs";
    #     options = [ "subvol=swap" ];
    # };

    # swapDevices = [];

    nixpkgs.hostPlatform = lib.mkDefault system;

    hardware = {
    	bluetooth = {
    		enable = true;
    		powerOnBoot = false;
    	};
    	cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    	graphics.enable = true;
    };

	# Temperature watcher:
    services.thermald.enable = true;
}
