{ config, lib, modulesPath, ... }:
{
    imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
    ];

    boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod" "alcor" ];
    boot.initrd.kernelModules = [];
    boot.kernelModules = [ "kvm-intel" ];
    boot.extraModulePackages = [];

    fileSystems."/" = {
        device = "/dev/disk/by-uuid/a461a7b1-ff20-4b53-b9fc-c36749f345ca";
        fsType = "btrfs";
        options = [ "subvol=root" ];
    };

    fileSystems."/nix" = {
        device = "/dev/disk/by-uuid/a461a7b1-ff20-4b53-b9fc-c36749f345ca";
        fsType = "btrfs";
        options = [ "subvol=nix" ];
    };

    fileSystems."/home" = {
        device = "/dev/disk/by-uuid/a461a7b1-ff20-4b53-b9fc-c36749f345ca";
        fsType = "btrfs";
        options = [ "subvol=home" ];
    };

    # fileSystems."/swap" = {
    #         device = "/dev/disk/by-uuid/a461a7b1-ff20-4b53-b9fc-c36749f345ca";
    #     fsType = "btrfs";
    #     options = [ "subvol=swap" ];
    # };

    fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/2362-65C4";
        fsType = "vfat";
        options = [ "fmask=0022" "dmask=0022" ];
    };

    # swapDevices = [];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

    hardware = {
    	bluetooth = {
    		enable = true;
    		powerOnBoot = false;
    	};
    	cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    	graphics.enable = true;
    	nvidia-container-toolkit.enable = true;
    	nvidia = {
    		# Property is read-only, should be set with services.xserver.videoDrivers:
    		# enabled = true;
    		# Enable the settings GUI (true by default):
    		# nvidiaSettings = true;
    		# Wayland requires kernel mode setting (KMS) to be enabled (highly recommended by NixOS wiki):
    		# modesetting.enable = true;
    		# powerManagement = {
    		# 	enable = true;
    		# 	finegrained = true;
    		# };
    		# My hardware does not support dynamic boost (Ampere or newer):
    		dynamicBoost.enable = false;
    		prime = {
    			offload.enable = true;
    			intelBusId = "PCI:0@0:2:0";
   			    nvidiaBusId = "PCI:1@0:0:0";
    		};
    		# Default is good enough (based on GPU package version):
    		# Set to a boolean because there's a bug where the null value is uncaught.
    		open = false;
    	};
    };
}
