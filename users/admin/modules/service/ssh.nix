{
  lib,
  config,
  inputs,
  configPath,
  ...
}:
{
  home.file = {
      ".ssh" = {
        source = config.lib.file.mkOutOfStoreSymlink "${inputs.secrets}/ssh";
        force = true;
      };
  };
}
