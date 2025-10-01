{
  description = "Nix operating system configuration flake.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    lsfg-vk-flake.url = "github:pabloaul/lsfg-vk-flake/main";
    lsfg-vk-flake.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, lsfg-vk-flake, ...}: 
  let
    userName = "connor";
    hostName = "nixos";
  in 
  {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ 
        ./modules/configuration.nix
        lsfg-vk-flake.nixosModules.default
      ];
      specialArgs = { inherit userName; inherit hostName; };
    };
  };
}
