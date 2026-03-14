{
  lib,
  config,
  configPath,
  ...
}:
{
  home.file = {
    ".config/fastfetch" = {
      source = config.lib.file.mkOutOfStoreSymlink "${configPath}/fastfetch";
      force = true;
    };
  };
}
