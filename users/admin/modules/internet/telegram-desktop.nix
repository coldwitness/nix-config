{
  lib,
  pkgs,
  hostConfig,
  ...
}:
let
  cfg = hostConfig.internet.telegram-desktop;
  finallyEnable = cfg.enable && (hostConfig.desktop.type != "");
in
{
  config = lib.mkIf finallyEnable {
    home.packages = with pkgs; [
      telegram-desktop
    ];
  };
}
