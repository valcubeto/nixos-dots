{ pkgs, main-user, ... }:
{
    # Enable touchpad support (enabled default in most desktop managers):
    # services.libinput.enable = true;

    services = {
    	# sudo-rs = {
    	#     enable = true;
    	#     execWheelOnly = true;
    	# };
    	# displayManager = {
    	# 	gdm.enable = true;
    	# };
    	# desktopManager = {
    	# 	gnome.enable = true;
    	# };
	    # Auto-login in the kernel console:
    	getty.autologinUser = main-user;
    	# jellyfin.enable = true;
	    openssh = {
	    	enable = true;
	    	settings = {
	    		PasswordAuthentication = false;
	    	};
	    };

	    # To enable power saver/performance modes:
	    power-profiles-daemon.enable = true;    # powerprofilesctl set power-saver

	    # Auto-start Hyprland on boot:
	    greetd = {
	        enable = true;
	        settings.default_session = {
	            user = main-user;
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
}
