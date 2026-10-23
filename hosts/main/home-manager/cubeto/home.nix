{ pkgs, ... }:
{
    home = {
    	username = "cubeto";
    	uid = 1000;
    	homeDirectory = "/home/cubeto";
    	stateVersion = "26.05"; # DO NOT CHANGE
    	# Added in 26.11, so unstable feature:
		# backupFileExtension = "old";
    };

    home.packages = with pkgs; [ fastfetch ];

  	services = {
  		# Enable bluetooth media-control buttons:
  		mpris-proxy.enable = true;
  	};

	# TODO: set up .config
	# fs.xdg = "";

    programs = {
    	chromium = {
    		enable = true;
    		package = pkgs.unstable.brave-origin;
    	};
    	zed-editor = {
    		enable = true;
    		# extensions = [
    		#     "nix"
    		#     "rust"
    		#     "python"
    		#     "c"
    		#     "zig"
    		#     "toml"
    		#     "yaml"
   			#     "json"
    		# ];
    	};
        kitty = {
            enable = true;
            font = {
            	name = "JetBrains Mono Nerd Font";
            	size = 11;
            };
            settings = {
            	enable_audio_bell = false;
            	background_opacity = 0.9;
            };
        };
    };
}
