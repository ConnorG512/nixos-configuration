dry-run-desktop:
  echo "Running dry run desktop"
  nixos-rebuild dry-run --flake  .#desktop --impure

dry-run-laptop:
  echo "Running dry run laptop"
  nixos-rebuild dry-run --flake  .#laptop --impure

build-desktop:
  echo "Building desktop."
  nixos-rebuild boot --flake  .#desktop --impure
  echo "Done, please reboot."

build-laptop:
  echo "Building laptop."
  nixos-rebuild boot --flake  .#laptop --impure
  echo "Done, please reboot."
