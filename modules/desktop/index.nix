{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
      ./hyprland.nix
      ./dms.nix
    ];

  environment.variables = {
    # 让 Electron 自动判断当前系统环境
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
  };
}
