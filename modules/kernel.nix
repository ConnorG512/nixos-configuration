{ config, pkgs, ... }:

{
  # Latest linux kernel:
  # kernelPackages = pkgs.linuxPackages_latest;

  boot = {
    # Boot parameters.
    kernelParams = [ "split_lock_detect=off" ];
  };
}
