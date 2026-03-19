{
  lib,
  config,
  modulesPath,
  ...
}:
{
  imports = [
    ./cpu.nix
    ./boot.nix
    ./file.nix
    ./zram.nix
    ./network.nix
    ./graphics.nix
    ./bluetooth.nix
    # 导入 NixOS 官方提供的硬件自动检测模块, 会根据当前硬件生成相应的内核模块列表, 并处理一些特定硬件的配置
    (modulesPath + "/installer/scan/not-detected.nix")
  ];
}
