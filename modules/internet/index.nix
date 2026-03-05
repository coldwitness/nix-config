{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
      ./firefox.nix
      ./rustdesk.nix
      ./qq-wayland.nix
    ];
}
