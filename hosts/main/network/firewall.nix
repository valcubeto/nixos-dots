{ ... }:
{
    networking = {
	    # Open ports in the firewall:
	    # networking.firewall.allowedTCPPorts = [ ... ];
	    # networking.firewall.allowedUDPPorts = [ ... ];
    	firewall.enable = true;

	    # networking.proxy.default = "http://user:password@proxy:port/";
	    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
	};
}
