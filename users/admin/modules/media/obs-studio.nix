{
  lib,
  hostConfig,
  ...
}:
let
  cfg = hostConfig.media.obs-studio;
  finallyEnable = cfg.enable && (hostConfig.desktop.type != "");
in
{
  config = lib.mkIf finallyEnable {
    programs.obs-studio = {
      enable = true;
    };
  };
}
