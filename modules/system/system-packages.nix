{config, pkgs, ... }:
let 
  codecs = import ./multimedia-codec.nix { inherit pkgs; };
in
{
  # Core system packages installed to all users.
  environment.systemPackages = with pkgs; [
    fuse3
    exfat
    nixfmt-rfc-style
    wl-clipboard
    gamescope
  ]
  ++ codecs.gstreamerCodecs
  ++ codecs.ffmpegCodecs; 
}
