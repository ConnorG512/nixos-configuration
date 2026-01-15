{config, ...}:

{
  # Currently auto detecting DNS from router however sometimes failing and cutting internet.
  # Force use of public DNS addresses and disable auto resolving.
  services.resolved.enable = false; 
  netowrking.nameservers = [
    "8.8.8.8" # Google
    "1.1.1.1" # Cloudflare Primary
    "1.0.0.1" # Cloudflare Secondary
  ];
}
