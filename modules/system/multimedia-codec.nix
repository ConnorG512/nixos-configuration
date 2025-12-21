{pkgs, ...}:

{
  gstreamerCodecs = with pkgs.gst_all_1; [
    gstreamer
    gst-vaapi
    gst-libav
    gst-plugins-ugly
    gst-plugins-bad
    gst-plugins-good
    gst-plugins-base
  ];
  
  ffmpegCodecs = with pkgs; [
    ffmpeg_7
  ];
}
