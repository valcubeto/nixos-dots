{ ... }:
{
    imports = [
        ./display.nix
    ];

    services = {
    	# jellyfin.enable = true;

	    openssh = {
	    	enable = true;
	    	settings = {
	    		PasswordAuthentication = false;
	    	};
	    };

	    # To enable power saver/performance modes:
	    power-profiles-daemon.enable = true;    # powerprofilesctl set power-saver

	    # Enable sound:
		pipewire = {
	        enable = true;
	        # Enable PulseAudio retro compatibility:
	        pulse.enable = true;
	    };
	};
}
