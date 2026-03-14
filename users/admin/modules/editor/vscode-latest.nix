{
  lib,
  config,
  configPath,
  ...
}:
{
  home.file = {
    ".vscode/argv.json" = {
      source = config.lib.file.mkOutOfStoreSymlink "${configPath}/vscode/argv.json";
      force = true;
    };
    ".config/Code/User/settings.json" = {
      source = config.lib.file.mkOutOfStoreSymlink "${configPath}/vscode/settings.json";
        force = true;
    };
  };
}
