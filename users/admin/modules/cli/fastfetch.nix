{
  lib,
  pkgs,
  config,
  configPath,
  ...
}:
{
  home.packages = with pkgs; [
    fastfetch
  ];
  home.file = {
    ".config/fastfetch" = {
      source = config.lib.file.mkOutOfStoreSymlink "${configPath}/fastfetch";
      force = true;
    };
  };
}
