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
    ./systemd-boot.nix
  ];
}
