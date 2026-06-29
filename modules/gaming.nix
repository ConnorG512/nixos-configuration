{ config, pkgs, lib, ... }:

let
  cfg = config.systemConfiguration.gaming;
in 
{
  options.systemConfiguration.gaming = {
    enableSteam = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the use of the steam client.";
      example = true;
    };

    enableHeroic = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable to use of heroic launcher.";
      example = true;
    };
    
    enableLsfg = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Lossless Scaling Frame Generation VK.";
      example = true;
    };

    enableGamemode = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable GameMode";
      example = true;
    };
    
    enableMangohud = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Mangohud";
      example = true;
    };
    
    enableUmu = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Umu launcher.";
      example = true;
    };
    
    enablelGogDownloader = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable lgogdownloader.";
      example = true;
    };

    extraPackages = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [ ];
      description =  "List of extra packages to add to system packages.";
      example = [ pkgs.mangohud pkgs.gamemode ];
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.enableSteam {
      programs.steam = {
        enable = true;
        remotePlay.openFirewall = true;                                     # Open ports in the firewall for Steam Remote Play
        dedicatedServer.openFirewall = true;                                # Open ports in the firewall for Source Dedicated Server
        localNetworkGameTransfers.openFirewall = true;

        gamescopeSession.enable = true;

        protontricks = {
          enable = true;
        };
      };
    })

    (lib.mkIf cfg.enableGamemode {
      programs.gamemode = {
        enable = true;
      };
    })

    {
      environment.systemPackages = cfg.extraPackages
        ++ lib.optionals cfg.enableLsfg [ pkgs.lsfg-vk pkgs.lsfg-vk-ui ] 
        ++ lib.optional cfg.enableHeroic pkgs.heroic
        ++ lib.optional cfg.enableUmu pkgs.umu-launcher
        ++ lib.optional cfg.enablelGogDownloader pkgs.lgogdownloader
        ++ lib.optional cfg.enableMangohud pkgs.mangohud;
    }
  ];
}

