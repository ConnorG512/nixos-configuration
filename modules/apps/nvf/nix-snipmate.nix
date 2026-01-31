[
  {
    trigger = "mkOption";
    body = ''
      mkOption {
        type = $1;
        default = $2;
        description = $3;
        example = $4;
      }
    '';
  }

  {
    trigger = "configOptionPreset";
    body = ''
      { config, lib, ... }:

      let
        cfg = config.$1
      in
      {
        options.$1 = {
          enable = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = "enable option.";
            example = true;
          };
        };

        config = lib.mkIf cfg.enable {
          # Do things.
        };
      }
    '';
  }

  {
    trigger = "mkDerivation";
    body = ''
      stdenv.mkDerivation (finalAttrs: {
        pname = "$1";
        version = "$2"
        src = $3;
      });
    '';
  }

  {
    trigger = "mkShell";
    body = ''
      devShells.$1.default = $2.mkShell {
        packages = with $2; [
          
        ];

        shellHook = ''
          echo "Entering shell!"
        '';
      }
    '';
  }
]
