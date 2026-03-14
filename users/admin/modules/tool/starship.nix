{
  lib,
  config,
  configPath,
  ...
}:
{
  home.file = {
    ".config/starship.toml" = {
      source = config.lib.file.mkOutOfStoreSymlink "${configPath}/starship/starship.toml";
      force = true;
    };
  };
}
