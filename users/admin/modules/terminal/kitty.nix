{
  lib,
  config,
  configPath,
  ...
}:
{
  home.file = {
    ".config/kitty" = {
      source = config.lib.file.mkOutOfStoreSymlink "${configPath}/kitty";
      force = true;
    };
  };
}
