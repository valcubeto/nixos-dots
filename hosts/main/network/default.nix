{ main-host, ... }:
{
	imports = [
		./firewall.nix
	];

	networking = {
		hostName = main-host;
		# IMPORTANT:
		networkmanager = {
			enable = true;
		};
	};
}
