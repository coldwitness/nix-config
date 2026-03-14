{
  lib,
  config,
  secrets,
  configPath,
  ...
}:
{
  home.file = {
      ".ssh" = {
        source = config.lib.file.mkOutOfStoreSymlink "${secrets}/ssh";
        force = true;
      };
  };
}
