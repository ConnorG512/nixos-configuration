{ ... }:

{
  # Use for virt-manager and qemu.
  virtualisation = {
    libvirtd = {
      enable = true;
    };

    spiceUSBRedirection.enable = true;
  };

  programs.virt-manager = {
    enable = true;
  };

  users = {
    groups.libvirtd.members = [ "connor" ];
    users.connor.extraGroups = [ "libvirtd" ];
  };
}
