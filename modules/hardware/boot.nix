{
  lib,
  pkgs,
  hostConfig,
  ...
}:
let
  cpuType = hostConfig.hardware.cpu.type;
in
{
  boot = {
    # 引导加载器配置
    loader = {
        # 启用 systemd-boot 引导程序
        systemd-boot.enable = true;
        # 允许修改 EFI 变量, 支持 UEFI 引导
        efi.canTouchEfiVariables = true;
      };
    # 覆盖 NixOS 使用的 Linux 内核
    kernelPackages = pkgs.linuxPackages_zen;
    initrd ={
      # 初始 ramdisk 中在启动过程中使用的内核模块集
      availableKernelModules = [
        # USB 3.0(xHCI)主机控制器驱动, 支持 USB 3.0 接口
        "xhci_pci"
        # SATA AHCI 控制器驱动, 支持 SATA 硬盘/SSD
        "ahci"
        # USB Attached SCSI 驱动, 提高 USB 存储设备性能
        "uas"
        # USB 存储设备驱动
        "usb_storage"
        # USB HID 驱动, 支持 USB 输入设备
        "usbhid"
        # SCSI 磁盘驱动, 为 SATA/SAS/USB 存储提供通用支持
        "sd_mod"
      ];
      # 始终由 initrd 加载的模块集
      kernelModules = [ ];
    };
    # 在启动过程的第二阶段要加载的内核模块集
    kernelModules = [
      
    ] ++ lib.optionals (cpuType == "amd") [
      "kvm-amd"
    ] ++ lib.optionals (cpuType == "intel") [
      "kvm-intel"
    ];
    # 提供内核模块的附加软件包列表
    extraModulePackages = [ ];
  };
}
