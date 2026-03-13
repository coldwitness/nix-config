{
  lib,
  config,
  secrets,
  ...
}:
let
  configPath = "${config.home.homeDirectory}/workspace/nix-config/users/admin/config";
in
{
  # 导入其他模块
  imports = [
    ./modules
    ];
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
      ".config/hypr" = {
        # 源文件
        source = config.lib.file.mkOutOfStoreSymlink "${configPath}/hyprland";
        # 强制覆盖目标文件
        force = true;
      };
      ".config/DankMaterialShell" = {
        source = config.lib.file.mkOutOfStoreSymlink "${configPath}/dms";
        force = true;
      };
      ".config/qt6ct" = {
        source = config.lib.file.mkOutOfStoreSymlink "${configPath}/qt6ct";
        force = true;
      };
      ".config/kitty" = {
        source = config.lib.file.mkOutOfStoreSymlink "${configPath}/kitty";
        force = true;
      };
      ".config/starship.toml" = {
        source = config.lib.file.mkOutOfStoreSymlink "${configPath}/starship/starship.toml";
        force = true;
      };
      ".config/fish" = {
        source = config.lib.file.mkOutOfStoreSymlink "${configPath}/fish";
        force = true;
      };
      ".config/fcitx5" = {
         source = config.lib.file.mkOutOfStoreSymlink "${configPath}/fcitx5";
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
      ".config/fastfetch" = {
        source = config.lib.file.mkOutOfStoreSymlink "${configPath}/fastfetch";
        force = true;
      };
      ".config/obs-studio" = {
        source = config.lib.file.mkOutOfStoreSymlink "${configPath}/obs-studio";
        force = true;
      };
      ".ssh" = {
        source = config.lib.file.mkOutOfStoreSymlink "${secrets}/ssh";
        force = true;
      };
    };
  };
}
