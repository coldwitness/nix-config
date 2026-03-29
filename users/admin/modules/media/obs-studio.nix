{
  lib,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.media.obs-studio or { };
  finallyEnable = cfg.enable or false && ((hostOptions.desktop.type or "") != "");
in
{
  config = lib.mkIf finallyEnable {
    programs.obs-studio = {
      enable = true;
    };
  };
}
