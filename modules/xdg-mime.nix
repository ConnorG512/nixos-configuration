{ config, pkgs, ... }:

{
  xdg.mime {
    enable = true;
    defaultApplication = {
      "application/pdf" = [ 
        "okular.desktop" "firefox.desktop"
      ];
      
      "application/x-krita" = "krita.desktop";
      
      "application/x-blender" = "blender.desktop";
      
      "image/png" = [
        "feh.desktop" "krita.desktop" "firefox.desktop"
      ];
      
      "image/jpeg" = [
        "feh.desktop" "krita.desktop" "firefox.desktop"
      ];
      
      "audio/mp4" = [
        "termusic.desktop" "mpv.desktop" 
      ];

      "video/mp4" = [
        "mpv.desktop" "firefox.desktop"
      ];

      "text/plain" = [
        "nvim.desktop" "vim.desktop" "firefox.desktop"
      ];

    };
  };
}
