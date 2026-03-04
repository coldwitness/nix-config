{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  programs = {
    dms-shell = {
      enable = true;
    };
  };
}
