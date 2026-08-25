dry-run host="desktop":
  @echo "Running dry run {{host}}"
  nixos-rebuild dry-run --flake  .#{{host}} --impure
  @echo "Done."

build mode="boot" host="desktop":
  @echo "Building {{host}} with mode: {{mode}}."
  nixos-rebuild {{mode}} --flake  .#{{host}} --impure
  @echo "Done."

format:
  @nix fmt .
