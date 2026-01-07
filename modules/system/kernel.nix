{ pkgs, ... }:

{
  # Latest linux kernel:

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    # Boot parameters.
    kernelParams = [ "split_lock_detect=off" ];
    kernelModules = [ "ntsync" ];
  };
}
