{
  lib,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.media.obs-studio;
  finallyEnable = cfg.enable && (hostOptions.desktop.type != "");
in
{
  config = lib.mkIf finallyEnable {
    programs.obs-studio = {
      enable = true;
    };
  };
}
