{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: {

    nixosConfigurations.default = inputs.nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        {
          nix.settings = { 
      	    experimental-features = ["nix-command" "flakes"]; 
        	  trusted-users = [ "root" "ligt" ];
      	  };
	      }
        ./hosts/default/configuration.nix
     	  ./hosts/default/noctalia.nix
     	  inputs.home-manager.nixosModules.default
      ];
    };
  };
}
