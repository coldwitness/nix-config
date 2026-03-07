{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./bat.nix
    ./eza.nix
    ./btop.nix
    # ./htop.nix
    # ./nvtop.nix
    ./fastfetch.nix
    ];
}
