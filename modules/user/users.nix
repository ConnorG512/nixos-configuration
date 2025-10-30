{ config, pkgs, userName, ... }:

{
  # Creating directories in the user homes dir.
  systemd.tmpfiles.rules = [
    "d /home/${userName}/documents 0755 ${userName} ${userName} -"
    "d /home/${userName}/pictures 0755 ${userName} ${userName} -"
    "d /home/${userName}/videos 0755 ${userName} ${userName} -"
    "d /home/${userName}/music 0755 ${userName} ${userName} -"
    "d /home/${userName}/.btrfsSnapshot 0755 ${userName} ${userName} -"
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {

    defaultUserShell = pkgs.zsh;

    users.${userName}= {
      isNormalUser = true;
      home = "/home/${userName}";
      description = "${userName}";
      extraGroups = [ "networkmanager" "wheel" "gamemode" ];

      useDefaultShell = true;

      # User installed packages
      packages = with pkgs; [
      yt-dlp
      keepassxc
      firefox-bin 
      syncthing
      mpv
      gearlever
      termusic
      qbittorrent
      mpvpaper
      winetricks
      git
      lazygit
      btop
      wget
      lf
      unzip
      fastfetch
      tmux
      fzf
      wineWowPackages.wayland
      podman
      distrobox
      boxbuddy
      dxvk
      vkd3d-proton
      blender
      gparted
      mangohud
      protonup
      obs-studio
      blender
      krita
      inkscape
      libreoffice-qt6-fresh
      grim 
      slurp 
      gnumake
      cmakeWithGui
      rocmPackages.clang
      cava
      ncurses
      valgrind
      luanti
      # nzportable
      gdb
      lutris
      kdbg
      kdePackages.ark
      kdePackages.kdenlive
      kdePackages.okular
      ghidra-bin
      tor-browser
      localsend
      scanmem
      strace
      kdePackages.ghostwriter

      # UNFREE
      steam
      discord-canary
      spotify
      ];
    };
  };
  
  nix.settings.trusted-users = [ "root" "@wheel" "connor" ];
}
