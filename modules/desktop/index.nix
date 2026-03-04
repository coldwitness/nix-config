{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
      ./hyprland.nix
      ./dms-shell.nix
    ];
}
