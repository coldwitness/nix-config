{
  lib,
  pkgs,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.tool.mission-center or { };
  finallyEnable = cfg.enable or false && ((hostOptions.desktop.type or "") != "");
in
{
  config = lib.mkIf finallyEnable {
    environment.systemPackages = with pkgs; [
      mission-center
    ];
  };
}
