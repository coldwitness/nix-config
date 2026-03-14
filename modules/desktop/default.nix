{
  ...
}:
{
  imports = [
    ./dms.nix
    ./greetd.nix
    ./hyprland.nix
  ];

  environment.variables = {
    # 让 Electron 自动判断当前系统环境
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
  };
}
