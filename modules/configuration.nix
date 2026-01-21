# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:
{
  # Enable NixOS experimental features.
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  imports = [
    # System
    ./system/amd-gpu.nix
    ./system/system-packages.nix
    ./system/dyn-libraries.nix
    ./system/kernel.nix
    ./system/audio/pipewire.nix
    ./system/locale/keymap.nix
    ./system/locale/locale.nix
    ./system/shell/zsh.nix
    ./system/bootloader.nix
    
    ./system/networking/networking.nix
    ./system/networking/dns.nix
    ./system/networking/firewall.nix

    # requires --impure
    /etc/nixos/hardware-configuration.nix

    ./user/users.nix
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
    ./apps/pcmanfm.nix
    ./apps/gnupg.nix
    ./apps/gamescope.nix
    ./apps/podman.nix
    ./apps/machine-vm.nix
    ./apps/nvf/nvim-nvf.nix
    ./apps/nff.nix
    
    ./services/searx.nix
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

  services.lsfg-vk.enable = true;
}
