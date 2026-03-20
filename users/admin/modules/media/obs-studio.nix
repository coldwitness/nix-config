{
  lib,
  pkgs,
  config,
  configPath,
  ...
}:
{
  home.packages = with pkgs; [
    obs-studio
  ];
  home.file = {
    ".config/obs-studio" = {
      source = config.lib.file.mkOutOfStoreSymlink "${configPath}/obs-studio";
      force = true;
    };
  };
}
