{ config, pkgs, ... }:

{
  xdg.mime = {
    enable = true;
    defaultApplications = {
      # Application
      "application/pdf" = [ 
        "okular.desktop" "firefox.desktop"
      ];
      
      "application/x-krita" = "krita.desktop";
      
      "application/x-blender" = "blender.desktop";
      
      # Image
      "image/png" = [
        "feh.desktop" "krita.desktop" "firefox.desktop"
      ];
      
      "image/jpeg" = [
        "feh.desktop" "krita.desktop" "firefox.desktop"
      ];
      
      # Audio
      "audio/mp4" = [
        "termusic.desktop" "mpv.desktop" 
      ];
      
      "audio/mp3" = [
        "termusic.desktop" "mpv.desktop" 
      ];
      
      # Video
      "video/mp4" = [
        "mpv.desktop" "firefox.desktop"
      ];
      
      # Text
      "text/plain" = [
        "nvim.desktop" "vim.desktop" "firefox.desktop"
      ];

    };
  };
}
