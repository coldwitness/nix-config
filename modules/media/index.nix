{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
      ./mpv.nix
      ./obs-studio.nix
    ];
}
