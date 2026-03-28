{
  lib,
  pkgs,
  config,
  configPath,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.desktop.dms;
  finallyEnable = cfg.enable && (hostOptions.desktop.type != "");
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
