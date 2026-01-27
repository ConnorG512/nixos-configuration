{ ... }:

let
  userName = "connor";
in 
{
  imports = [
    ./details.nix
    ./directories.nix
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
  
  # Home manager.
  programs.home-manager.enable = true;
  home-manager.users.${userName} = {
    imports = [
      ./configuration-files.nix
      ./installed-packages.nix
    ];

    home = {
      username = userName;
      homeDirectory = "/home/${userName}";
      stateVersion = "24.11";
    };
  };
}
