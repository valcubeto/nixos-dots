{ pkgs, main-user, ... }:
{
    services = {
        # Enable touchpad support (enabled default in most desktop managers):
        # libinput.enable = true;
        desktopManager = {
            xfce.enable = true;
    		# gnome.enable = true;
        };
        displayManager = {
    		# gdm.enable = true;
            lightdm.enable = true; # xfce
        };

	    # Auto-login in the kernel console:
    	getty.autologinUser = main-user;

	    # Auto-start DM on boot:
	    greetd = {
	        enable = true;
	        settings = {
    	        default_session = {
    	            user = main-user;
    	            command = "echo 'welcome'";
    	        };
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
	};
}
