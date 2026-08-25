dry-run host="desktop":
  echo "Running dry run {{host}}"
  nixos-rebuild dry-run --flake  .#{{host}} --impure

build host="desktop":
  echo "Building {{host}}."
  nixos-rebuild boot --flake  .#{{host}} --impure
  echo "Done, please reboot."

