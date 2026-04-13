{
  lib,
  opts,
  ...
}:
let
  cfg = opts.media.mpv or { };
  finallyEnable = cfg.enable or false && ((opts.desktop.type or "") != "");
in
{
  config = lib.mkIf finallyEnable {
    programs.mpv = {
      enable = true;
      config = {
        # 循环播放
        loop-playlist = "inf";
      };
    };
  };
}
