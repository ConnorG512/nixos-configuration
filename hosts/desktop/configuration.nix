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
    ./system/gpu/gpu.nix
    ./system/system-packages.nix
    ./system/kernel.nix
    ./system/audio/pipewire.nix
    ./system/locale/keymap.nix
    ./system/locale/locale.nix
    ./system/shell/zsh.nix
    ./system/bootloader.nix
    ./system/environment-vars.nix
    ./system/controllers.nix

    ./appimage.nix

    ./theming/dark-theme.nix
    ./theming/fonts.nix

    ./desktop/wm/hyprland.nix
    ./desktop/wm/niri.nix

    ./apps/xdg-mime.nix
    ./apps/openssh.nix
    ./apps/gamemode.nix
    ./apps/steam.nix
    ./apps/syncthing.nix
    ./apps/mullvad-vpn.nix
    ./apps/gnupg.nix
    ./apps/gamescope.nix
    ./apps/podman.nix
    ./apps/machine-vm.nix
    ./apps/nvf/nvim-nvf.nix
    ./apps/nff.nix
    ./apps/ngircd.nix
    ./apps/gpu-screen-recorder.nix
    
    ./services/searx.nix
    ./services/sunshine.nix
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
      groupList = [ "wheel" "libvirtd" ];
      useZsh = true;
      userPackageList = (import ./user-packages.nix);
      configFileList = (import ./config-files.nix);
    };
    networking = {
      firewall = {
        enable = true;
        openedPorts = [ 80 443 5069 8080 30000 40050 42069 53317 ];
      };
      dns = 
      let
        providerList = (import "${self}/modules/system/networking/dns-provider-list.nix");
      in 
      {
        enable = false;
        providers = providerList.quadNine.malwareDNSSEC ++ providerList.cloudFlare.malware;
      };
    };
  }; 
  
  networking = {
    hostName = "nixos";
    
    networkmanager = {
      enable = true;
      dhcp = "internal";
      unmanaged = [ ];
      settings = { };
      plugins = [ ];

      ethernet.macAddress = "preserve";
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
