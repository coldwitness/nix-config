{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  # 系统级包列表
  environment.systemPackages = with pkgs; [
    # 系统信息显示工具
    fastfetch
    # 进程监控系统资源
    htop
    # AMD GPU 监控工具
    nvtopPackages.amd
  ];
}
