{
  lib,
  pkgs,
  inputs,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.desktop;
  finallyEnable = (cfg.type or "") != "";
in
{
  config = lib.mkIf finallyEnable {
    environment ={
      systemPackages = with pkgs; [
        # 图标主题
        papirus-icon-theme
      ];
      variables = {
        # 指定 Qt 应用程序的外观主题
        QT_QPA_PLATFORMTHEME = "gtk3";
        # QT_QPA_PLATFORMTHEME = "qt6ct";
        # 让 Electron 自动判断当前系统环境
        ELECTRON_OZONE_PLATFORM_HINT = "auto";
      };
    };
  };
}
