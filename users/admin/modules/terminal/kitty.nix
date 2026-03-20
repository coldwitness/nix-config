{
  lib,
  pkgs,
  config,
  configPath,
  ...
}:
{
  home.packages = with pkgs; [
    kitty
  ];
  home.file = {
    ".config/kitty" = {
      source = config.lib.file.mkOutOfStoreSymlink "${configPath}/kitty";
      force = true;
    };
  };
}
