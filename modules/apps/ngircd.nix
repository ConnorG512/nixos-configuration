{ pkgs, config, ... }:

{
  services.ngircd = {
    enable = true;
  };
}
