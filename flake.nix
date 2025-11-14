{
  description = "Nix operating system configuration flake.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    lsfg-vk-flake.url = "github:pabloaul/lsfg-vk-flake/main";
    lsfg-vk-flake.inputs.nixpkgs.follows = "nixpkgs";
    nvf.url = "github:notashelf/nvf";
  };
  
  outputs = { nixpkgs, lsfg-vk-flake, nvf, ...}: 
  let 
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in
  {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ 
        ./modules/configuration.nix
        lsfg-vk-flake.nixosModules.default
	nvf.nixosModules.default
      ];
      specialArgs = { 
        prefUser = import ./preferences/user/user.nix {
          inherit pkgs;
        }; 
        prefSystem = import ./preferences/system.nix;
        prefNetwork = import ./preferences/networking.nix;
      };
    };
  };
}
