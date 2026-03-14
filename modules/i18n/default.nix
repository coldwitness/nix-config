{
  pkgs,
  ...
}:
{
  imports = [
    ./chinese.nix
  ];
  # 输入法配置(Fcitx5)
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      addons = with pkgs; [
        fcitx5-mellow-themes
      ];
      waylandFrontend = true;
    };
  };
}
