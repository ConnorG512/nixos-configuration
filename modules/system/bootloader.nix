{ ... }:

{

  boot.loader = {
    systemd-boot = {
      enable = true;
      windows = { };
      graceful = false;
      extraEntries = { };
      editor = false;

      memtest86.enable = false;
    };

    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
  };
}
