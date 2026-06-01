# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ self, pkgs, inputs, ... }:
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
      extraPackages = with pkgs; [
        tmux
        btop
      ];
    };
    user = {
      name = "connor";
      groupList = [ "users" "wheel" "networkmanager" "libvirtd" "podman" "gamemode" ];
      userPackageList = (import ./user-packages.nix) { inherit pkgs inputs; };
      configFileList = (import ./config-files.nix) { inherit self; };
    };
    network = {
      hostName = "nixos-desktop";
      enable = true;
      additionalPorts = [ 53317 42069 8080 47989 ];
      enableOpenssh = true;
      enableAvahi = true;
    };
    multimedia = let
      audioDevices = {
        headphones = "alsa_output.pci-0000_08_00.1.pro-output-10";
        tv = "alsa_output.pci-0000_08_00.1.pro-output-3";
      };
    in {
      audio = {
        plugins = [ "audio" "jack" "pulse" "alsa" ];
        clockRate = 44100;
        hiddenPorts = [
          "alsa_output.pci-0000_08_00.1.pro-output-0"
          "alsa_output.pci-0000_08_00.1.pro-output-1"
          "alsa_output.pci-0000_08_00.1.pro-output-2"
          "alsa_output.pci-0000_08_00.1.pro-output-4"
          "alsa_output.pci-0000_08_00.1.pro-output-5"
          "alsa_output.pci-0000_08_00.1.pro-output-6"
          "alsa_output.pci-0000_08_00.1.pro-output-7"
          "alsa_output.pci-0000_08_00.1.pro-output-8"
          "alsa_output.pci-0000_08_00.1.pro-output-9"
          "alsa_output.pci-0000_08_00.1.pro-output-11"
        ];
        renamedPorts = [
          {
            target = audioDevices.headphones;
            newName = "Headphones";
          }
          {
            target = audioDevices.tv;
            newName = "TV";
          }
        ];
        loopbackModules = [
          {
            fileName = "90-discord-splitter";
            nodeName = "discord_splitter";
            nodeDescription = "Sink for splitting Discord capture audio";
            targetOutput = audioDevices.headphones;
          }
        ];
        sinkModules = [
          {
            fileName = "93-tv-headphones-sink";
            nodeName = "discord_splitter";
            nodeDescription = "TV/Headphone Combine Stream";
            targets = [
              audioDevices.headphones
              audioDevices.tv
            ];
          }
        ];
      };
      gstreamer = {
        enable = true;
        enableUgly = true;
      };
    };
    desktop = {
      niri = {
        enable = false;
        enableSatellite = false;
      };
      kde = {
        enable = true;
      };
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
