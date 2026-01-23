{
  description = "Nix operating system configuration flake.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    lsfg-vk-flake.url = "github:pabloaul/lsfg-vk-flake/main";
    lsfg-vk-flake.inputs.nixpkgs.follows = "nixpkgs";
    nvf.url = "github:notashelf/nvf";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nff.url = "git+file:///home/connor/programming/nix/nff";
  };

  outputs =
    inputs@{
      nixpkgs,
      lsfg-vk-flake,
      nvf,
      home-manager,
      nff,
      ...
    }:
    let
      pkgsUnfree = import nixpkgs {
        system = "x86_64-linux";
        config = {
          allowUnfree = true;
        };
      };
    in
    {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          pkgs = pkgsUnfree;
          modules = [
            ./modules/configuration.nix
            nff.nixosModules.fastfetch
            lsfg-vk-flake.nixosModules.default
            nvf.nixosModules.default
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.connor = import ./user-preferences/home.nix;
            }
          ];
          specialArgs = {
            prefUser = import ./user-preferences/user.nix {
              inherit pkgsUnfree;
            };
            prefSystem = import ./user-preferences/system.nix;
            prefNetwork = import ./user-preferences/networking.nix;
          };
        };
      };
    };
}
