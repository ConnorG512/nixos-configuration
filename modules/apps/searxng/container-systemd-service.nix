{ pkgs, congfig, ... }:

{
  systemd.user.services.searxng-container = {
    enable = true;
    description = "SearXNG services running as a Docker container.";
    serviceConfig = {
      ExecStart = "${pkgs.podman}/bin/podman run --rm --network=host docker.io/searxng/searxng:latest";
    };
    wantedBy = ["default.target"]; # For a user service. Required to auto boot the service when user logs on.
  };
}
