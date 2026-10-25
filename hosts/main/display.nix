{ pkgs, main-user, ... }:
{
    programs = {
        niri.enable = true;
        hyprland = {
            enable = true;
            xwayland.enable = true;
        };
    };

    environment = {
        # cosmic = {
        #     excludePackages = with pkgs; [
        #         cosmic-term
        #         cosmic-store
        #         cosmic-edit
        #         cosmic-monitor
        #         cosmic-reader
        #     ];
        # };
    };

    services = {
        # Enable touchpad support (enabled default in most desktop managers):
        # libinput.enable = true;
        # xserver.desktopManager.xfce.enable = true; # no xfce?
        # lightdm.enable = true; # xfce
        desktopManager = {
            cosmic = {
                enable = false;
            };
    		# gnome.enable = true;
        };
        displayManager = {
            autoLogin = {
                enable = true;
                user = main-user;
            };
    		# gdm.enable = true;
    		cosmic-greeter = {
    		    enable = false;
    		};
        };

        # For COSMIC:
        system76-scheduler.enable = false;

	    # Auto-start DM on boot:
	    greetd = {
	        enable = false;
	        settings = {
    	        default_session = {
    	            user = main-user;
    	            command = "start-hyprland";
    	        };
    	    };
	    };

	    # Auto-login in the kernel console:
    	getty.autologinUser = main-user;

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
