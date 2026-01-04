{ pkgsUnfree }:

{
  userName = "connor";
  userGroups = [
    "networkmanager"
    "wheel"
    "gamemode"
    "libvirtd"
    "podman"
  ];

  homeDirNames = {
    documents = "documents";
    pictures = "pictures";
    videos = "videos";
    music = "music";
  };
}
