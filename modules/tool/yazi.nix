{
  config,
  lib,
  pkgs,
  ...
}:
{
  # 文件管理器
  programs = {
    yazi = {
      enable = true;
    };
  };
}
