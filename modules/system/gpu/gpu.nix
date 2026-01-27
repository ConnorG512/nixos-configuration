{ ... }:

{
  imports = [
    ./amd.nix
  ];

  systemConfiguration.amdGpu = {
    enable = true;
    enable32bit = true;
  };
}
