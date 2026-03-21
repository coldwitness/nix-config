{
  lib,
  pkgs,
  config,
  configPath,
  ...
}:
{
  # 输入法配置(Fcitx5)
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      addons = with pkgs; [
        fcitx5-mellow-themes
        qt6Packages.fcitx5-chinese-addons
      ];
      waylandFrontend = true;
    };
  };
  home.file = {
    ".config/fcitx5" = {
        source = config.lib.file.mkOutOfStoreSymlink "${configPath}/fcitx5";
        force = true;
    };
  };
}
