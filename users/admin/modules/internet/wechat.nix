{
  lib,
  pkgs,
  hostConfig,
  ...
}:
let
  cfg = hostConfig.internet.wechat;
  finallyEnable = cfg.enable && (hostConfig.desktop.type != "");
in
{
  config = lib.mkIf finallyEnable {
    home.packages = with pkgs; [
      # 这个版本有首次启动用不了输入法的问题
      # wechat
      wechat-uos
    ];
  };
}
