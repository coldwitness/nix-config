{
  lib,
  config,
  configPath,
  ...
}:
{
  home.file = {
    ".config/opencode/opencode.jsonc" = {
      source = config.lib.file.mkOutOfStoreSymlink "${configPath}/opencode/opencode.jsonc";
      force = true;
    };
  };
}
