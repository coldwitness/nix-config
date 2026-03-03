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
    ];
}
