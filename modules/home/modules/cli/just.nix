{
  lib,
  pkgs,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.cli.just or { };
  finallyEnable = cfg.enable or false;
in
{
  config = lib.mkIf finallyEnable {
    home.packages = with pkgs; [
      just
    ];
  };
}
