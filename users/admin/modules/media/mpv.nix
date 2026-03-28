{
  lib,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.media.mpv;
  finallyEnable = cfg.enable && (hostOptions.desktop.type != "");
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
