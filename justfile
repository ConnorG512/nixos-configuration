dry-run host:
  @echo "Running dry run {{host}}"
  nixos-rebuild dry-run --flake  .#{{host}} --impure
  @echo "Done."

build host mode="boot":
  @echo "Building {{host}} with mode: {{mode}}."
  nixos-rebuild {{mode}} --flake  .#{{host}} --impure
  @echo "Done."

format:
  @nix fmt .
