{ config, pkgs, lib, ... }:

let
  cfg = config.systemConfiguration.wine;
in
{
  options.systemConfiguration.wine = {
    package = lib.mkOption {
      type = lib.types.enum [ "wayland" "waylandFull" "staging" "stagingFull" "none" ];
      default = "none";
      description = "Enable Wine.";
      example = "staging";
    };

    enableWineAsio = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable WineASIO driver.";
      example = true;
    };

    enableWineFonts = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Wine fonts.";
      example = true;
    };
  };

  config = lib.mkIf (cfg.package != "none") {
    environment.systemPackages = [
      pkgs.wine64Packages.${cfg.package}
      pkgs.winetricks
      pkgs.dxvk.out
      pkgs.vkd3d-proton
    ]
    ++ lib.optional cfg.enableWineAsio pkgs.wineasio
    ++ lib.optional cfg.enableWineFonts pkgs.wine64Packages.fonts;
  };
}
