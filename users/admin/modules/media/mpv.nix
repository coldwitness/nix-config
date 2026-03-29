{
  lib,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.media.mpv or { };
  finallyEnable = cfg.enable or false && ((hostOptions.desktop.type or "") != "");
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
