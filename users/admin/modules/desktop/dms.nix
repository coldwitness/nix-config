{
  lib,
  config,
  configPath,
  ...
}:
{
home.file = {
    ".config/DankMaterialShell" = {
      source = config.lib.file.mkOutOfStoreSymlink "${configPath}/dms";
      force = true;
    };
  };
}
