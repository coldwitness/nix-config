{
  lib,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.hardware.graphics;
  finallyEnable = cfg.enable;
in
{
  config = lib.mkIf finallyEnable {
    hardware.graphics = {
      # 是否启用硬件加速图形驱动
      enable = true;
      # 在 64 位系统上是否为 32 位应用程序(如 Wine)安装 32 位驱动程序
      enable32Bit = cfg.enable32Bit;
    };
  };
}
