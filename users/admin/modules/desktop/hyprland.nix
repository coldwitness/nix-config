{
  lib,
  config,
  configPath,
  ...
}:
{
  home.file = {
    ".config/hypr" = {
      source = config.lib.file.mkOutOfStoreSymlink "${configPath}/hyprland";
      force = true;
    };
  };
}
