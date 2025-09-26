{ config, pkgs, ... }:

{
  # Creating directories in the user homes dir.
  systemd.tmpfiles.rules = [
    "d /home/connor/documents 0755 connor connor -"
    "d /home/connor/pictures 0755 connor connor -"
    "d /home/connor/videos 0755 connor connor -"
    "d /home/connor/music 0755 connor connor -"
    "d /home/connor/.btrfsSnapshot 0755 connor connor -"
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.connor = {
    isNormalUser = true;
    home = "/home/connor";
    description = "connor";
    extraGroups = [ "networkmanager" "wheel" "gamemode" ];
    
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
    kdePackages.kdenlive
    grim 
    slurp 
    neovim
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
}
