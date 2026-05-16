{ pkgs, inputs, ... }:

with pkgs; [
  # Utility:
  yt-dlp
  unzip
  hdparm
  vulkan-tools
  patchelfUnstable
  mpvpaper
  keepassxc
  gparted
  cava
  kdePackages.ark
  kdePackages.okular
  qbittorrent
  xxd
  hexedit
  qpwgraph

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
  luanti
  protonup-ng
  steam
  prismlauncher
  steamtinkerlaunch
  heroic

  # Web browsing:
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
  irssi
  
  inputs.msc.packages.x86_64-linux.release
]
