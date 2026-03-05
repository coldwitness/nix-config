{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  programs = {
    dank-material-shell = {
      enable = true;
      systemd = {
        enable = false;             # Systemd service for auto-start
        restartIfChanged = true;   # Auto-restart dms.service when dms-shell changes
      };
      # Core features
      enableSystemMonitoring = true;     # System monitoring widgets (dgop)
      enableVPN = true;                  # VPN management widget
      enableDynamicTheming = true;       # Wallpaper-based theming (matugen)
      enableAudioWavelength = true;      # Audio visualizer (cava)
      # enableCalendarEvents = true;       # Calendar integration (khal)
      enableClipboardPaste = true;       # Pasting from the clipboard history (wtype)
    };
  };

  # 系统级包列表
  environment.systemPackages = with pkgs; [
    # 图标主题
    papirus-icon-theme  # 最流行, 覆盖最全
    # adwaita-icon-theme  # 备选, GNOME默认
    # breeze-icons        # 备选 ,KDE默认
    # 图标设置
    # nwg-look            # GTK 设置工具
    qt6Packages.qt6ct   # Qt 设置工具
  ];

  environment.variables = {
    # GTK 风格
    # QT_QPA_PLATFORMTHEME = "gtk3";
    # Qt 原生配置
    QT_QPA_PLATFORMTHEME = "qt6ct";
  };
}
