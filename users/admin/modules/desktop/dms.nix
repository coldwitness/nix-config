{
  lib,
  pkgs,
  config,
  configPath,
  hostConfig,
  ...
}:
let
  cfg = hostConfig.desktop.dms;
  finallyEnable = cfg.enable && (hostConfig.desktop.type != "");
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
