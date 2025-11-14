{ pkgs }:

{
  allowUnfreePackages = true;

  utility = with pkgs; [
    yt-dlp
    mangohud
    keepassxc
    gearlever
    fastfetch
    gparted
    cava
    localsend
    lf
    kdePackages.ark
    kdePackages.okular
    qbittorrent
  ];
  development = with pkgs; [
    git
    lazygit
    gef
    ghidra-bin
    kdbg
    strace
    scanmem
  ];
  gaming = with pkgs; [
    lutris
    dxvk
    vkd3d-proton
    wineWowPackages.wayland
    winetricks
    luanti
    protonup-ng
    steam
  ];
  webBrowsing = with pkgs; [
    firefox-bin 
    tor-browser
  ];
  productivity = with pkgs; [
    kdePackages.kdenlive
    kdePackages.ghostwriter
    krita
    inkscape
    blender
    obs-studio
    libreoffice-qt6-fresh
    blender
  ];
  entertainment = with pkgs; [
    spotify
    termusic
    mpv
  ];
  containerisation = with pkgs; [
    podman
    distrobox
    boxbuddy
  ];
  communication = with pkgs; [
    discord-canary
  ];
}
