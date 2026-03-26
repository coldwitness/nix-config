{
  lib,
  config,
  modulesPath,
  ...
}:
{
  imports = [
    ./boot.nix
    ./zram.nix
    ./network.nix
    ./graphics.nix
    ./bluetooth.nix
  ];
}
