{
  lib,
  modulesPath,
  ...
}:
let
  systemBootDevice = "/dev/disk/by-uuid/8875-2C68";
  systemFileDevice = "/dev/disk/by-uuid/ac688f46-6e23-467e-aeda-45c89f94a237";
in
{
  imports = [ (modulesPath + "/profiles/qemu-guest.nix") ];
  # 启动相关配置
  boot = {
    # initrd 阶段加载的模块 (根文件系统挂载前)
    initrd = {
      # 由 udev 自动探测加载的模块列表 (会打包进 initrd)
      # 这些模块用于在早期启动时识别硬件
      availableKernelModules = [
        # Intel PIIX3/4 IDE 控制器驱动, 支持旧式 PATA 硬盘
        "ata_piix"
        # USB UHCI 主机控制器驱动, 支持 USB 1.x 接口
        "uhci_hcd"
        # Virtio PCI 传输驱动, 为虚拟化环境提供 virtio 设备的 PCI 接口
        "virtio_pci"
        # Virtio 块设备驱动, 用于访问 virtio 虚拟磁盘 (如 QEMU/KVM 中的磁盘)
        "virtio_blk"
      ];
      # 不依赖自动探测强制加载的模块
      # 适用于根文件系统所在设备的驱动或任何必须在早期就绪的模块
      kernelModules = [ ];
    };
    # 第二阶段加载的模块 (根文件系统挂载后)
    # 这些模块由 systemd/udev 在系统启动后期加载非关键硬件或功能
    kernelModules = [ ];
    # 额外的第三方内核模块包
    # 如需在 initrd 阶段加载其中的模块, 请加入 initrd.kernelModules
    extraModulePackages = [ ];
  };
  # 要挂载的文件系统
  fileSystems = {
    "/boot/efi" = {
      device = systemBootDevice;
      fsType = "vfat";
      options = [
        "fmask=0022"
        "dmask=0022"
      ];
    };
    "/" = {
      device = systemFileDevice;
      fsType = "ext4";
    };
  };
  swapDevices = [ ];
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
