{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-stable, nixos-wsl, home-manager, ... } @ inputs:
    let
      machineSpecificValue = {
        userName = "bd00ff";
        hostName = "st-m5-wsl";
        systemArch = "x86_64-linux";
        isWSL = true;
      };

      mkNixosConfiguration = machineSpecific: nixpkgs.lib.nixosSystem {
        system = machineSpecific.systemArch;
        modules = [
          nixos-wsl.nixosModules.default
          ./hosts/${machineSpecific.hostName}/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${machineSpecific.userName} = (
              ./hosts/${machineSpecific.hostName}/${machineSpecific.userName}.home.nix
            );
          }
	  ({ lib, ... }: {
            options.machineSpecific = lib.mkOption {
	      type = lib.types.attrs;
              default = machineSpecific;
	    };
	  })
        ];
      };

    in {
      nixosConfigurations.${
        machineSpecificValue.hostName
      } = mkNixosConfiguration ( machineSpecificValue );
    };
}

