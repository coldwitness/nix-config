{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
      ./hyprland.nix
      ./dms.nix
    ];
}
