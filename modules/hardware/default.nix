{
  lib,
  config,
  modulesPath,
  ...
}:
{
  imports = [
    ./boot.nix
    ./file.nix
    ./zram.nix
    ./network.nix
    ./bluetooth.nix
    # 导入 NixOS 官方提供的硬件自动检测模块, 会根据当前硬件生成相应的内核模块列表, 并处理一些特定硬件的配置
    (modulesPath + "/installer/scan/not-detected.nix")
  ];
  # NixOS 首次安装的版本
  system.stateVersion = "25.11";
  # 更新 AMD 处理器的 CPU 微码
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
