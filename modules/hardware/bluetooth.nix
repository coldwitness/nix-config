{
  lib,
  hostConfig,
  ...
}:
let
  cfg = hostConfig.hardware.bluetooth;
  finallyEnable = cfg.enable;
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
