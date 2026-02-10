{ ... }:

{
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    allowSFTP = true;
    settings = {
      PasswordAuthentication = true;
      AllowUsers = null;
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "prohibit-password";
    };
  };
}
