{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, nixos-wsl, ... } @ inputs: {
    nixosConfigurations = {
      st-m5-wsl = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        system = "x86_64-linux";
        modules = [
          nixos-wsl.nixosModules.default
	  ./host/st-m5-wsl/configuration.nix
        ];
      };
    };
  };
}

