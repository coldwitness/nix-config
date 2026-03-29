{
  lib,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.hardware.bluetooth or { };
  finallyEnable = cfg.enable or false;
in
{
  config = lib.mkIf finallyEnable {
    hardware.bluetooth = {
      enable = true;
      # 是否在启动时启用默认的蓝牙控制器
      powerOnBoot = false;
    };
  };
}
