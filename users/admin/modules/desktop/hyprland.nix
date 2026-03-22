{
  lib,
  pkgs,
  config,
  configPath,
  hostConfig,
  ...
}:
let
  cfg = hostConfig.desktop;
  finallyEnable = cfg.type == "hyprland";
in
{
  config = lib.mkIf finallyEnable {
    home.file = {
      ".config/hypr" = {
        source = config.lib.file.mkOutOfStoreSymlink "${configPath}/hyprland";
        force = true;
      };
    };
  };
}
