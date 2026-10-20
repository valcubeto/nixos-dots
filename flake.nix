{
  description = "Cubeto's modern NixOS with Hyprland.";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
  	self,
  	nixpkgs,
  	nixpkgs-unstable,
  	nix-cachyos-kernel,
  	home-manager,
  	...
  } @ inputs:
  let
    system = "x86_64-linux";
    # This will allow us to create an attribute "unstable" for "nixpkgs".
    # So, instead of passing two different pkgs versions as different arguments,
    # we can use unstable packages with the following syntax: pkgs.unstable.brave-origin.
    nixpkgs-unstable-overlay = final: prev: {
      unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    };
  in
  {
    nixosConfigurations = {
      # This is just a label for the --flake argument.
      # If you don't use a hostname in the argument, it will use the current hostname you are logged in.
      nixos = nixpkgs.lib.nixosSystem {
        inherit system;

		specialArgs = {
			inherit inputs;
		};

        modules = [
          {
            nixpkgs.overlays = [
              nixpkgs-unstable-overlay
              nix-cachyos-kernel.overlays.pinned
            ];
          }
          ./hosts/main/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs   = true;
              useUserPackages = true;
              users = {
              	cubeto = import ./hosts/main/users/cubeto/home.nix;
              };
              backupFileExtension = "backup";
            };
          }
        ];
      };
    };
  };
}
