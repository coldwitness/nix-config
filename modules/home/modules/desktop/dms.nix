{
  lib,
  pkgs,
  config,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.desktop.dms or { };
  finallyEnable = cfg.enable or false && ((hostOptions.desktop.type or "") != "");
  configPath = "${hostOptions.nixConfigPath}/modules/home/config";
in
{
  config = lib.mkIf finallyEnable {
    home.file = {
      ".config/DankMaterialShell" = {
        source = config.lib.file.mkOutOfStoreSymlink "${configPath}/dms";
        force = true;
      };
    };
  };
}
