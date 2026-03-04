{
  config,
  lib,
  pkgs,
  ...
}:
let
  configPath = "${config.home.homeDirectory}/workspace/nix-config/users/admin/config";
in
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
        source = config.lib.file.mkOutOfStoreSymlink "${configPath}/hyprland/hyprland.conf";
        # 强制覆盖目标文件
        force = true;
      };
      ".config/starship.toml" = {
        source = config.lib.file.mkOutOfStoreSymlink "${configPath}/starship/starship.toml";
        force = true;
      };
      ".config/fish/config.fish" = {
        source = config.lib.file.mkOutOfStoreSymlink "${configPath}/fish/config.fish";
        force = true;
      };
      ".config/fcitx5/config" = {
         source = config.lib.file.mkOutOfStoreSymlink "${configPath}/fcitx5/config";
         force = true;
      };
      ".vscode/argv.json" = {
        source = config.lib.file.mkOutOfStoreSymlink "${configPath}/vscode/argv.json";
        force = true;
      };
      ".config/Code/User/settings.json" = {
        source = config.lib.file.mkOutOfStoreSymlink "${configPath}/vscode/settings.json";
         force = true;
      };
    };
  };
}
