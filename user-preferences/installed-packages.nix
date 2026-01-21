{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
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
    w3m-nox

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
    prismlauncher
    alvr
    steamtinkerlaunch

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
    spotify-player
    termusic
    youtube-tui
    mpv
    feh

    # Containerisation:
    podman
    distrobox
    boxbuddy
    podman-tui

    # Communication:
    discord-canary
    discordo
  ];
}
