{ ... }:

{
  imports = [
    ./details.nix
    ./directories.nix
  ];
  
  systemConfiguration = 
  let
    userName = "connor";
  in 
  {
    userDetails = {
      name = userName;
      groupList = [
        "${userName}"   
        "networkmanager"
        "wheel"
        "gamemode"
        "libvirtd"
        "podman"
      ];
      isTrustedUser = true;
      shellType = "zsh";
    };

    userDirectories = {
      createUserDirs = true;
      useUpperCaseNames = false;
    };
  }; 
}
