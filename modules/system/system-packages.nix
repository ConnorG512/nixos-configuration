{config, pkgs, ... }:

{
  # Core system packages installed to all users.
  environment.systemPackages = with pkgs; [
    fuse3
    exfat
    nixfmt-rfc-style
    wl-clipboard
    
    # ffmpeg
    ffmpeg_7
    # Gstreamer Codecs
    gst_all_1.gstreamer
    gst_all_1.gst-vaapi
    gst_all_1.gst-libav
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-base
  ];
}
