{ config, pkgs, ... }:
{
    home.username = "cubeto";
    home.homeDirectory = "/home/cubeto";
    home.stateVersion = "26.05";

    home.packages = with pkgs; [ ];

  	services = {
  		# Enable bluetooth media-control buttons:
  		mpris-proxy.enable = true;
  	};

	# TODO: set .config
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
            font.name = "JetBrains Mono Nerd Font";
            font.size = 11;
        };
    };
}
