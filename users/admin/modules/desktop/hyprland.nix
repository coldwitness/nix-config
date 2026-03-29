{
  lib,
  pkgs,
  config,
  configPath,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.desktop or { };
  finallyEnable = (cfg.type or "") == "hyprland" ;
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
