{ config, pkgs, nff, ... }:

{
  programs.nff = {
    enable = true; 

    settings = {

      logo = {
        type = "builtin";
        source = "auto";

        padding = {

          top = 0;
          left = 0;
          right = 0;
        };
      };

      display = {
        
        percent = {
          type = 9;
          color = {
            green = "green";
            yellow = "light_yellow";
            red = "light_red";
          };
        };

        key = {
          type = "string";
          width = 32;
        };
        
        bar = {
          width = 0;
        };
      };

      modules = [
        "title"
        "separator"
        {
          type = "os";
          key = "OS";
        }
        "host"
        "uptime"
        "separator"
        "cpu"
        "separator"
        "gpu"
        "vulkan"
        "opengl"
        "opencl"
        "separator"
        "memory"
        "separator"
        "disk"
        "separator"
        {
          type = "localip";
          showSpeed = true;
        }
      ];
    };
  };
}
