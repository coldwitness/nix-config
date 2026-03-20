{
  lib,
  pkgs,
  config,
  configPath,
  ...
}:
{
  home.packages = with pkgs; [
    opencode
  ];
  home.file = {
    ".config/opencode/opencode.jsonc" = {
      source = config.lib.file.mkOutOfStoreSymlink "${configPath}/opencode/opencode.jsonc";
      force = true;
    };
  };
}
