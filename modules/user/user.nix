{ ... }:

let
  userName = "connor";
in 
{
  imports = [
    ./details.nix
    ./directories.nix
  ];
  
  # Home manager.
  home-manager.users.${userName} = {
    programs.home-manager.enable = true;
    
    imports = [
      ./configuration-files.nix
      ./installed-packages.nix
      ./environment-vars.nix
    ];

    home = {
      username = userName;
      homeDirectory = "/home/${userName}";
      stateVersion = "24.11";
    };
  };
  
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
}
