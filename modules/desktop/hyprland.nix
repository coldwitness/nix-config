{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  # Hyprland 程序配置
  programs = {
    # Hyprland 的锁屏程序
    # hyprlock.enable = true;
    # Wayland 合成器/桌面环境
    hyprland = {
      # 启用 Hyprland Wayland 合成器
      enable = true;
      # 启用 XWayland 支持, 允许运行 X11 应用
      xwayland.enable = true;
      # 启用 UWSM 支持, 允许运行 Wayland 应用
      withUWSM = true;
    };
    # 文件管理器
    yazi = {
      enable = true;
    };
  };

  # 系统级包列表
  environment.systemPackages = with pkgs; [
    # 终端模拟器
    kitty
    # 程序启动器
    fuzzel
    # 状态栏
    waybar
  ];

  # Greetd 登录管理器配置
  services.greetd = {
    # 启用 Greetd Wayland 登录管理器
    enable = true;
    settings = {
      default_session = {
        # 使用 tuigreet 作为登录界面(基于终端的图形登录程序)
        command = "${lib.getExe pkgs.tuigreet}"
          # 指定会话路径, 包含 xsessions 和 wayland-sessions 目录
          + " --sessions ${config.services.displayManager.sessionData.desktops}/share/xsessions:${config.services.displayManager.sessionData.desktops}/share/wayland-sessions"
          # 显示当前时间
          + " --time"
          # 时间格式
          + " --time-format '%Y-%m-%d %H:%M'"
          # 密码输入时显示星号
          + " --asterisks"
          # 记住用户名
          + " --remember"
          # 记住会话
          + " --remember-session";
      };
    };
  };
}
