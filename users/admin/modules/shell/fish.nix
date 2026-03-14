{
  lib,
  config,
  configPath,
  ...
}:
{
  home.file = {
    ".config/fish" = {
      source = config.lib.file.mkOutOfStoreSymlink "${configPath}/fish";
      force = true;
    };
  };
}
