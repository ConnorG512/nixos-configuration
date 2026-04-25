{
  description = "Nix operating system configuration flake.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nvf.url = "github:notashelf/nvf";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nff.url = "git+file:///home/connor/programming/nix/nff";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
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
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
            }
            nff.nixosModules.fastfetch
            nvf.nixosModules.default
            "${self}/hosts/desktop/configuration.nix"
          ];
          specialArgs = {
            inherit self;
            prefUser = import ./user-preferences/user.nix {
              inherit pkgsUnfree;
            };
            prefSystem = import ./user-preferences/system.nix;
            prefNetwork = import ./user-preferences/networking.nix;
          };
        };

        laptop = nixpkgs.lib.nixosSystem {
          pkgs = pkgsUnfree; 
          modules = [
            nvf.nixosModules.default
            nff.nixosModules.fastfetch
            "${self}/hosts/laptop/configuration.nix"
          ];
          specialArgs = {
            inherit self;
          };
        };
      };
    };
}
