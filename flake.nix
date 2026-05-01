{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
  };

  outputs = { self, nixpkgs, nixpkgs-stable, nixos-wsl, ... } @ inputs:
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
          ./host/${machineSpecific.hostName}/configuration.nix
	  ({ lib, ... }: {
            options.machineSpecific = lib.mkOption {
	      type = lib.types.attrs;
              default = machineSpecific;
	    };
	  })
        ];
      };
    in {
      nixosConfigurations.${machineSpecificValue.hostName} = mkNixosConfiguration (
        machineSpecificValue
      );
    };
}

