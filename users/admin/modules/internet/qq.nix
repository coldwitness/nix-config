{
  lib,
  pkgs,
  hostConfig,
  ...
}:
let
  cfg = hostConfig.internet.qq;
  finallyEnable = cfg.enable && (hostConfig.desktop.type != "");
in
{
  config = lib.mkIf finallyEnable {
    home.packages = with pkgs; [
      qq
    ];
  };
}
