{ ... }:

{
  services.pipewire = {
    enable = true;
    audio.enable = true;

    jack.enable = true;
    pulse.enable = true;
    alsa.enable = true;

    extraConfig.pipewire = {
      "context.properties" = {
        "default.clock.rate" = 44100;
      };
    };
  };
}
