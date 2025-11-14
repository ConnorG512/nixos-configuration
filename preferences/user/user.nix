{ pkgs }:

{
  userPackages = import ./packages.nix { inherit pkgs; };

  userName = "connor";
  userGroups = [
    "networkmanager" 
    "wheel" 
    "gamemode"
  ];

  homeDirNames = {
   documents = "documents";
   pictures = "pictures";
   videos = "videos";
   music = "music";
  };
}
