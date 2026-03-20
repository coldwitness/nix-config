{
  lib,
  pkgs,
  config,
  configPath,
  ...
}:
{
  home.packages = with pkgs; [
    starship
  ];
  home.file = {
    ".config/starship.toml" = {
      source = config.lib.file.mkOutOfStoreSymlink "${configPath}/starship/starship.toml";
      force = true;
    };
  };
}
