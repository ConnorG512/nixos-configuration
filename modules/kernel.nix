{ config, pkgs, ... }:

{
  # Latest linux kernel:
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Kernel boot params
  boot.kernelParams = [ "split_lock_detect=off" ];
}
