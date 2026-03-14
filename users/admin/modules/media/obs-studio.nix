{
  lib,
  config,
  configPath,
  ...
}:
{
  home.file = {
    ".config/obs-studio" = {
      source = config.lib.file.mkOutOfStoreSymlink "${configPath}/obs-studio";
      force = true;
    };
  };
}
