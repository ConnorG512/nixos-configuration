[
  {
    trigger = "linuxPkgsX86_64";
    body = ''
      $1 = nixpkgs.legacyPackages.x86_64-linux;
    '';
  }

  {
    trigger = "linuxMingwW64Pkgs";
    body = ''
      $1 = nixpkgs.legacyPackages.x86_64-linux.pkgsCross.mingwW64;
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
    trigger = "mkDerivation";
    body = ''
      stdenv.mkDerivation (finalAttrs: {
        pname = "$1";
        version = "$2";
        src = $3;

        dontStrip = $4;

        nativeBuildInputs = [ ];
        buildInputs = [ ];
      });
    '';
  }

  {
    trigger = "buildPhase";
    body = ''
      buildPhase = ""
        runHook preBuild
        $0
        runHook postBuild
      "";
    '';
  }
  
  {
    trigger = "installPhase";
    body = ''
      installPhase = ""
        runHook preInstall
        $0
        runHook postInstall
      "";
    '';
  }
  
  {
    trigger = "cmakeFlags"; 
    body = ''
      cmakeFlags = [
        "-DCMAKE_BUILD_TYPE=$1"
        $0
      ];
    '';
  }

  {
    trigger = "mkShell";
    body = ''
      devShells.$1.default = $2.mkShell {
        packages = [ ];

        shellHook = ""
          echo "Entering shell!"
        "";
      }
    '';
  }

  {
    trigger = "wrapProgram";
    body = ''
      wrapProgram $1 \
        $2
    '';
  }

  {
    trigger = "importsList";
    body = ''
      imports = [
        $0
      ];
    '';
  }
  
  {
    trigger = "import";
    body = ''
      $1 = import $2;
    '';
  }

  {
    trigger = "importAndAppend";
    body = ''
      $1 = (import $2).$3;
    '';
  }
]
