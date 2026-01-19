{ pkgs, congfig, ... }:

{
  systemd.user.services.searxng-container = {
    enable = true;
    description = "SearXNG services running as a Docker container.";
    serviceConfig = {
      ExecStart = "${pkgs.podman}/bin/podman run -d --name searxng --network=host docker.io/searxng/searxng:latest";
    };
  };
}
