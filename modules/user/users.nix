{ pkgs, prefUser, ... }:

{
  # Creating directories in the user homes dir.
  systemd.tmpfiles.rules = [
    "d /home/${prefUser.userName}/${prefUser.homeDirNames.documents} 0755 ${prefUser.userName} ${prefUser.userName} -"
    "d /home/${prefUser.userName}/${prefUser.homeDirNames.pictures} 0755 ${prefUser.userName} ${prefUser.userName} -"
    "d /home/${prefUser.userName}/${prefUser.homeDirNames.videos} 0755 ${prefUser.userName} ${prefUser.userName} -"
    "d /home/${prefUser.userName}/${prefUser.homeDirNames.music} 0755 ${prefUser.userName} ${prefUser.userName} -"
    "d /home/${prefUser.userName}/.btrfsSnapshot 0755 ${prefUser.userName} ${prefUser.userName} -"
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    defaultUserShell = pkgs.zsh;

    users.${prefUser.userName}= {
      isNormalUser = true;
      home = "/home/${prefUser.userName}";
      description = "${prefUser.userName}";
      extraGroups = prefUser.userGroups;

      useDefaultShell = true;
    };
  };
  
  nix.settings.trusted-users = [ "root" "@wheel" "${prefUser.userName}" ];
}
