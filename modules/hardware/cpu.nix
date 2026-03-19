{
  lib,
  config,
  ...
}:
{
  hardware.cpu = {
    # 更新 AMD 处理器的 CPU 微码
    amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
