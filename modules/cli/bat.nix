{
  lib,
  pkgs,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.cli.bat;
  finallyEnable = cfg.enable;
in
{
  config = lib.mkIf finallyEnable {
    environment.systemPackages = with pkgs; [
      bat
    ];
  };
}
