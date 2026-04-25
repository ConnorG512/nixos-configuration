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
    "${self}/modules/system/audio/pipewire.nix"
    "${self}/modules/system/system-packages.nix"
    "${self}/modules/system/shell/zsh.nix"
    "${self}/modules/system/controllers.nix"

    "${self}/modules/system/networking/firewall.nix"
    "${self}/modules/system/networking/dns.nix"
    
    "${self}/modules/user.nix"

    "${self}/modules/desktop/de/lxqt.nix"

    "${self}/modules/appimage.nix"
    "${self}/modules/apps/nff.nix"
    "${self}/modules/apps/nvf/nvim-nvf.nix"
    "${self}/modules/apps/openssh.nix"
    "${self}/modules/apps/mullvad-vpn.nix"
    "${self}/modules/apps/pcmanfm.nix"
  ];

  systemConfiguration = {
    sysPackages = {
      displayType = "x11";
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
      groupList = [ "wheel" ];
      useZsh = true;
      userPackageList = (import ./user-packages.nix) { inherit pkgs; };
      configFileList = (import ./config-files.nix) { inherit self; };
    };
    networking = {
      firewall = {
        enable = true;
        openedPorts = [ 80 443 53317 42069 ];
      };
      dns = {
        enable = false;
        providers = (import ../../modules/system/networking/dns-provider-list.nix).cloudFlare.malware;
      };
    };
  }; 

  programs.localsend = {
    enable = true;
    openFirewall = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
