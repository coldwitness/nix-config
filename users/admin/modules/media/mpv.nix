{
  lib,
  hostConfig,
  ...
}:
let
  cfg = hostConfig.media.mpv;
  finallyEnable = cfg.enable && (hostConfig.desktop.type != "");
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
