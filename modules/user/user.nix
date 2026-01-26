{ ... }:

let
  userName = "connor";
in 
{
  imports = [
    ./details.nix
    ./directories.nix
    ./configuration-files.nix
    ./installed-packages.nix
  ];
  
  systemConfiguration = 
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

  programs.home-manager.enable = true;
  home-manager.users.${userName} = {
    home = {
      username = userName;
      homeDirectory = "/home/${userName}";
      stateVersion = "24.11";
      file = (import ./configuration-files.nix).file;
    };
  };
}
