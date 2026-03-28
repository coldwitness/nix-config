{
  lib,
  config,
  modulesPath,
  ...
}:
{
  imports = [
    ./zram.nix
    ./network.nix
    ./graphics.nix
    ./bluetooth.nix
    ./boot-loader.nix
  ];
}
