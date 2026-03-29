{
  pkgs,
  lib,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.tool.pince or { };
  finallyEnable = cfg.enable or false && ((hostOptions.desktop.type or "") != "");
in
{
  config = lib.mkIf finallyEnable {
    environment.systemPackages = with pkgs; [
      pince
    ];
  };
}
