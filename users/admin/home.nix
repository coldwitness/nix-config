{
  config,
  lib,
  pkgs,
  ...
}:
{
  # 用户配置
  home = {
    # 用户名
    username = "admin";
    # 用户 home 目录
    homeDirectory = "/home/admin";
    # 状态版本
    stateVersion = "26.05";
    # 链接文件
    file = {
      # 目标文件
      ".config/hypr/hyprland.conf" = {
        # 源文件
        source = ./config/hyprland/hyprland.conf;
        # 强制覆盖目标文件
        force = true;
      };
      ".config/starship.toml" = {
        source = ./config/starship/starship.toml;
        force = true;
      };
      ".config/fish/config.fish" = {
        source = ./config/fish/config.fish;
        force = true;
      };
      ".config/fcitx5/config" = {
         source = ./config/fcitx5/config;
         force = true;
      };
    };
  };
}
