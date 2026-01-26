{config, lib, ...}:

let
  cfg = config.systemConfiguration.dns;
in 
{
  options.systemConfiguration.dns = {
    enableAutomaticDns = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the use of automatic DNS.";
      example = true;
    };

    providers = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = (import ./dns-provider-list.nix).google.standard;
      description = "List of providers to enable in the DNS";
      example = [ "8.8.8.8" "1.1.1.1" ];
    };
  };
  
  config = lib.mkIf (cfg.enableAutomaticDns == false) {
    # Turn off the router automatic DNS:
    networking.networkmanager.dns = "none";
    networking.nameservers = cfg.providers;
  };
}
