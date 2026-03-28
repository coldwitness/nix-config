{
  lib,
  pkgs,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.internet.telegram-desktop;
  finallyEnable = cfg.enable && (hostOptions.desktop.type != "");
in
{
  config = lib.mkIf finallyEnable {
    home.packages = with pkgs; [
      telegram-desktop
    ];
  };
}
