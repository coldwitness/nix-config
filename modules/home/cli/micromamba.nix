{
  lib,
  pkgs,
  opts,
  ...
}:
let
  cfg = opts.cli.micromamba or { };
  finallyEnable = cfg.enable or false;
in
{
  config = lib.mkIf finallyEnable {
    home.packages = with pkgs; [
      micromamba
    ];
  };
}
