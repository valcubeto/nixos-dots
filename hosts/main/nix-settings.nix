{ inputs, ... }:
{
    nix = {
	    settings = {
	    	experimental-features = [ "nix-command" "flakes" ];
	    	auto-optimise-store = true;
	    	warn-dirty = false;
	    	bash-prompt-prefix = "(nix-shell) ";
	    	# Default is undefinitely:
	    	connect-timeout = 10;
	    	# Maximum overdrive:
	    	cores = 0;
	    	max-jobs = "auto";
	    	# Default is 5:
	    	download-attempts = 3;
	    	# WARNING: "true" improves robustness in case of system crashes, but reduces performance:
	    	fsync-metadata = false;
	    	show-trace = true;
	    };
	    nixPath = [
	    	"nixpkgs=${inputs.nixpkgs}"
	    	"nixpkgs-unstable=${inputs.nixpkgs-unstable}"
	    ];
	};
}
