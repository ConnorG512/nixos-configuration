{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Utility:
    yt-dlp
    unzip
    hdparm
    vulkan-tools
    pwvucontrol
    patchelfUnstable
    mpvpaper
    keepassxc
    gearlever
    gparted
    cava
    localsend
    kdePackages.ark
    kdePackages.okular
    qbittorrent
    radeontop
    w3m-nox
    xxd
    hexedit

    # Development:
    git
    lazygit
    gef
    ghidra-bin
    kdbg
    strace
    scanmem
    cloc

    # Gaming:
    lutris
    #wineWowPackages.wayland
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
    irssi
  ];
}
