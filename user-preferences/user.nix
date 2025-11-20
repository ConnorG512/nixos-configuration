{ pkgsUnfree }:

{
  userName = "connor";
  userGroups = [
    "networkmanager" 
    "wheel" 
    "gamemode"
    "libvirtd"
  ];

  homeDirNames = {
   documents = "documents";
   pictures = "pictures";
   videos = "videos";
   music = "music";
  };
}
