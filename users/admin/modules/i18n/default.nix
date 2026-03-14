{
  lib,
  config,
  configPath,
  ...
}:
{
  home.file = {
    ".config/fcitx5" = {
        source = config.lib.file.mkOutOfStoreSymlink "${configPath}/fcitx5";
        force = true;
    };
  };
}
