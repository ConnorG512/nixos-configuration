# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ self, pkgs, ... }:
{
  # Enable NixOS experimental features.
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  
  nix.settings.trusted-users = [
    "root"
    "@wheel"
  ];

  imports = [
    # requires --impure
    /etc/nixos/hardware-configuration.nix
    
    "${self}/modules/system/kernel.nix"
    "${self}/modules/system/gpu/intel.nix"
    "${self}/modules/system/bootloader.nix"
    "${self}/modules/system/system-packages.nix"
    "${self}/modules/system/shell/zsh.nix"
    "${self}/modules/system/controllers.nix"
    "${self}/modules/system/networking/networking.nix"
    "${self}/modules/system/multimedia/multimedia.nix"

    "${self}/modules/user.nix"

    "${self}/modules/system/locale/keymap.nix"
    "${self}/modules/system/locale/locale.nix"

    "${self}/modules/desktop/desktop.nix"

    "${self}/modules/appimage.nix"
    "${self}/modules/apps/nff.nix"
    "${self}/modules/apps/nvf/nvim-nvf.nix"
    "${self}/modules/apps/mullvad-vpn.nix"
    "${self}/modules/apps/pcmanfm.nix"
    "${self}/modules/apps/firefox.nix"
    "${self}/modules/apps/localsend.nix"
  ];

  systemConfiguration = {
    sysPackages = {
      displayType = "wl";
      installManPages = true;
      installWinePackages = true;
      installTuiUitls = true;
      extraPackages = with pkgs; [
        tmux
        btop
        ripgrep
      ];
    };
    user = {
      name = "connor";
      groupList = [ "wheel" "networkmanager" ];
      userPackageList = (import ./user-packages.nix) { inherit pkgs; };
      configFileList = (import ./config-files.nix) { inherit self; };
    };
    network = {
      hostName = "nixos-laptop";
      enable = true;
      additionalPorts = [ 53317 42069 ];
      enableOpenssh = true;
      enableAvahi = true;
    };
    multimedia = {
      audio = {
        plugins = [ "audio" "jack" "pulse" "alsa" ];
        clockRate = 44100;
      };
      gstreamer = {
        enable = true;
        enableUgly = true;
      };
    };
    desktop.kde = {
      enable = true;
      useQt5 = true;
      useX11 = false;
      loginManager = "plasma";
    };
  }; 

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
