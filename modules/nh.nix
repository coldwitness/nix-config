{
  config,
  lib,
  pkgs,
  ...
}:
{
  # NH 程序配置
  programs.nh = {
    # 启用 NH 程序
    enable = true;
    # 启用 NH 程序的清理功能
    # clean.enable = true;
    # 配置 NH 程序的清理参数
    # clean.extraArgs = "--keep-since 4d --keep 3";
    # 设置 NH_OS_FLAKE 变量
    flake = "/etc/nixos";
  };
}
