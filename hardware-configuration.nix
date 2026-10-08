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

  fileSystems."/swap" = {
  	device = "/dev/disk/by-uuid/a461a7b1-ff20-4b53-b9fc-c36749f345ca";
    fsType = "btrfs";
    options = [ "subvol=swap" ];
  };

  fileSystems."/boot" = {
  	device = "/dev/disk/by-uuid/2362-65C4";
    fsType = "vfat";
    options = [ "fmask=0022" "dmask=0022" ];
  };

  # swapDevices = [];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
