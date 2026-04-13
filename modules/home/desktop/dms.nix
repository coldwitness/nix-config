{
  lib,
  pkgs,
  opts,
  config,
  ...
}:
let
  cfg = opts.desktop.dms or { };
  finallyEnable = cfg.enable or false && ((opts.desktop.type or "") != "");
  configPath = "${opts.nixConfigPath}/modules/config";
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
