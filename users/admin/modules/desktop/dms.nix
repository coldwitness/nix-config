{
  lib,
  pkgs,
  config,
  configPath,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.desktop.dms or { };
  finallyEnable = cfg.enable or false && ((hostOptions.desktop.type or "") != "");
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
