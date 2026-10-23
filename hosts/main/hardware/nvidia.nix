{ pkgs, ... }:
{
    hardware = {
    	graphics = {
    		enable = true;
    		# enable32Bit = true;
    	};
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

    # (Also works for wayland):
    services.xserver.videoDrivers = [ "nvidia" ];

	environment.systemPackages = with pkgs; [ nvidia-vaapi-driver ];
}
