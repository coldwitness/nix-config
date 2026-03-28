{
  lib,
  pkgs,
  inputs,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.desktop.dms;
  finallyEnable = cfg.enable && (hostOptions.desktop.type != "");
in
{
  imports = [
    ./dms.nix
    ./hyprland.nix
  ];
  environment ={
    systemPackages = with pkgs; [
      # 图标主题
      papirus-icon-theme
      # GTK 设置工具
      nwg-look
      # Qt 设置工具
      qt6Packages.qt6ct
    ];
    variables = {
      # 指定 Qt 应用程序的外观主题
      QT_QPA_PLATFORMTHEME = "gtk3";
      # QT_QPA_PLATFORMTHEME = "qt6ct";
      # 让 Electron 自动判断当前系统环境
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
    };
  };
}
