{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Core:

    # Utility:
    yt-dlp
    mangohud
    lsof
    unzip
    hdparm
    vulkan-tools
    pwvucontrol
    file
    fileinfo
    tmux
    openssl
    curl
    patchelfUnstable
    goverlay
    cloc
    tree
    inetutils
    btop
    mpvpaper
    keepassxc
    gearlever
    gparted
    cava
    localsend
    lf
    kdePackages.ark
    kdePackages.okular
    qbittorrent
    man
    man-pages
    man-pages-posix
    radeontop
    fzf
    fastfetch

    # Development:
    git
    lazygit
    gef
    ghidra-bin
    kdbg
    strace
    scanmem

    # Gaming:
    lutris
    dxvk
    vkd3d-proton
    wineWowPackages.wayland
    winetricks
    luanti
    protonup-ng
    steam

    # Web browsing:
    firefox-bin
    tor-browser

    # productivity:
    kdePackages.kdenlive
    kdePackages.ghostwriter
    krita
    inkscape
    blender
    obs-studio
    libreoffice-qt6-fresh
    blender

    # Entertainment:
    spotify
    termusic
    mpv
    feh

    # Containerisation:
    podman
    distrobox
    boxbuddy

    # Communication:
    discord-canary
    discordo
  ];
}
