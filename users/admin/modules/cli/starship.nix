{
  lib,
  pkgs,
  config,
  configPath,
  ...
}:
{
  programs.starship = {
    enable = true;
  };
  home.file = {
    ".config/starship.toml" = {
      source = config.lib.file.mkOutOfStoreSymlink "${configPath}/starship/starship.toml";
      force = true;
    };
  };
}
