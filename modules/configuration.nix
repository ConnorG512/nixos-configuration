# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  # Enable NixOS experimental features.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  imports =
    [ 
      # Hardware configuration will be different per computer installed on.
      # This requires --impure flag as breaks Nix's purity rules.
      /etc/nixos/hardware-configuration.nix 

      ./kernel.nix
      ./networking.nix
      ./system-packages.nix
      ./users.nix
      ./fonts.nix
      ./dyn-libraries.nix
      ./appimage.nix
      ./systemd-resolve.nix
      ./shell/zsh.nix
      ./amd-gpu.nix
      ./dark-theme.nix
      # wm / de
      ./desktop/wm/hyprland.nix
      # Apps 
      ./apps/xdg-mime.nix
      ./apps/openssh.nix
      ./apps/gamemode.nix
      ./apps/steam.nix
      ./apps/syncthing.nix
      ./apps/mullvad-vpn.nix
      ./apps/pcmanfm.nix
      ./apps/gnupg.nix
      ./apps/gamescope.nix
      ./apps/podman.nix
      ./apps/machine-vm.nix
      # Locale 
      ./locale/keymap.nix
      ./locale/locale.nix
      # Audio
      ./audio/pipewire.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
  
  services.lsfg-vk.enable = true;  
}
