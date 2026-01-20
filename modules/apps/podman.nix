{ ... }:

{
  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  security.wrappers = {
    newuid = {
      owner = "root";
      group = "root";
      source = "${pkgs.su}/bin/newuidmap";
      setuid = true;
    };
    newgid = {
      owner = "root";
      group = "root";
      source = "${pkgs.su}/bin/newgidmap";
      setuid = true;
    };
  };
}
