{
  pkgs,
  lib,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.cli.pince;
  finallyEnable = cfg.enable;
in
{
  config = lib.mkIf finallyEnable {
    environment.systemPackages = with pkgs; [
      pince
    ];
  };
}
