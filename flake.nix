{
  description = "Nix operating system configuration flake.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nvf.url = "github:notashelf/nvf";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nff.url = "github:ConnorG512/nff";
    msc.url = "github:ConnorG512/msc";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nvf,
      home-manager,
      nff,
      msc,
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
        desktop = nixpkgs.lib.nixosSystem {
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
            inherit inputs;
          };
        };

        laptop = nixpkgs.lib.nixosSystem {
          pkgs = pkgsUnfree; 
          modules = [
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
            }
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
