{
  lib,
  opts,
  ...
}:
let
  cfg = opts.media.obs-studio or { };
  finallyEnable = cfg.enable or false && ((opts.desktop.type or "") != "");
in
{
  config = lib.mkIf finallyEnable {
    programs.obs-studio = {
      enable = true;
    };
  };
}
