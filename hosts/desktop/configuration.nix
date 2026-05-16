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
    
    # System
    "${self}/modules/system/gpu/gpu.nix"
    "${self}/modules/system/system-packages.nix"
    "${self}/modules/system/kernel.nix"
    "${self}/modules/system/locale/keymap.nix"
    "${self}/modules/system/locale/locale.nix"
    "${self}/modules/system/shell/zsh.nix"
    "${self}/modules/system/bootloader.nix"
    "${self}/modules/system/environment-vars.nix"
    "${self}/modules/system/controllers.nix"
    "${self}/modules/system/networking/networking.nix"
    "${self}/modules/system/multimedia/multimedia.nix"

    "${self}/modules/appimage.nix"

    "${self}/modules/theming/dark-theme.nix"
    "${self}/modules/theming/fonts.nix"

    "${self}/modules/desktop/desktop.nix"

    "${self}/modules/apps/xdg-mime.nix"
    "${self}/modules/apps/gamemode.nix"
    "${self}/modules/apps/steam.nix"
    "${self}/modules/apps/syncthing.nix"
    "${self}/modules/apps/mullvad-vpn.nix"
    "${self}/modules/apps/gnupg.nix"
    "${self}/modules/apps/gamescope.nix"
    "${self}/modules/apps/podman.nix"
    "${self}/modules/apps/machine-vm.nix"
    "${self}/modules/apps/nvf/nvim-nvf.nix"
    "${self}/modules/apps/nff.nix"
    "${self}/modules/apps/ngircd.nix"
    "${self}/modules/apps/gpu-screen-recorder.nix"
    "${self}/modules/apps/firefox.nix"
    "${self}/modules/apps/localsend.nix"
    
    "${self}/modules/services/searx.nix"
    "${self}/modules/services/sunshine.nix"
    "${self}/modules/user.nix"
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
      ];
    };
    user = {
      name = "connor";
      groupList = [ "users" "wheel" "networkmanager" "libvirtd" "podman" "gamemode" ];
      userPackageList = (import ./user-packages.nix) { inherit pkgs; };
      configFileList = (import ./config-files.nix) { inherit self; };
    };
    network = {
      hostName = "nixos-desktop";
      enable = true;
      additionalPorts = [ 53317 42069 8080 47989 ];
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
    desktop.niri = {
      enable = true;
      enableSatellite = true;
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
