{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./btop.nix
    # ./htop.nix
    # ./nvtop.nix
    ./fastfetch.nix
    ];
}
