{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./nh.nix
    ./bat.nix
    ./eza.nix
    ./btop.nix
    # ./htop.nix
    # ./nvtop.nix
    ./fastfetch.nix
    ];
}
