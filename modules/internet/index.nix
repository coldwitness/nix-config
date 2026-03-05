{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
      ./qq.nix
      ./firefox.nix
      ./rustdesk.nix
    ];
}
