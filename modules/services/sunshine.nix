{config, pkgs, ...}:

{
  services.sunshine = {
    enable = true;
    autoStart = true;
    settings = {
      locale = "en_GB";
      sunshine_name = "connor-nix-desktop";
      min_log_level = "info";
      keyboard = "enabled";
      port = 47989;
    };
    openFirewall = true;
  };
}
