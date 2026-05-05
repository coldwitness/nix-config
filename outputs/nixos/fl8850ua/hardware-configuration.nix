{
  lib,
  pkgs,
  vars,
  config,
  modulesPath,
  ...
}:
let
  systemBootDevice = "/dev/disk/by-uuid/027B-7471";
  systemFileDevice = "/dev/disk/by-uuid/8c18bbfc-4114-497a-b34b-760429d94a25";
in
{
  # 硬件自动检测模块, 会根据当前硬件生成相应的内核模块列表, 并处理一些特定硬件的配置
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];
  # 启动相关配置
  boot = {
    # Linux 内核
    kernelPackages = (vars.kernelPackages pkgs).latest;
    # initrd 阶段加载的模块(根文件系统挂载前)
    initrd = {
      # 由 udev 自动探测加载的模块列表(会打包进 initrd)
      # 这些模块用于在早期启动时识别硬件
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
      # 不依赖自动探测强制加载的模块
      # 适用于根文件系统所在设备的驱动或任何必须在早期就绪的模块
      kernelModules = [ ];
    };
    # 第二阶段加载的模块(根文件系统挂载后)
    # 这些模块由 systemd/udev 在系统启动后期加载非关键硬件或功能
    kernelModules = [
      # AMD 虚拟化支持(KVM 模块)
      "kvm-amd"
    ];
    # 额外的第三方内核模块包
    # 如需在 initrd 阶段加载其中的模块, 请加入 initrd.kernelModules
    extraModulePackages = with config.boot.kernelPackages; [ ];
  };
  # 生成多套启动配置
  specialisation = {
    lqx.configuration = {
      boot.kernelPackages = lib.mkForce (vars.kernelPackages pkgs).lqx_latest;
    };
    zen.configuration = {
      boot.kernelPackages = lib.mkForce (vars.kernelPackages pkgs).zen_latest;
    };
  };
  # 要挂载的文件系统
  fileSystems = {
    "/boot" = {
      device = systemBootDevice;
      fsType = "vfat";
      options = [
        "fmask=0022"
        "dmask=0022"
      ];
    };
    "/" = {
      device = systemFileDevice;
      fsType = "btrfs";
      options = [
        "subvol=@"
        "noatime"
        "compress=zstd"
      ];
    };
    "/.snapshots" = {
      device = systemFileDevice;
      fsType = "btrfs";
      options = [
        "subvol=@snapshots"
        "compress=zstd"
      ];
    };
    "/home" = {
      device = systemFileDevice;
      fsType = "btrfs";
      options = [
        "subvol=@home"
        "compress=zstd"
      ];
    };
    "/home/.snapshots" = {
      device = systemFileDevice;
      fsType = "btrfs";
      options = [
        "subvol=@home-snapshots"
        "compress=zstd"
      ];
    };
    "/nix" = {
      device = systemFileDevice;
      fsType = "btrfs";
      options = [
        "subvol=@nix"
        "noatime"
        "compress=zstd"
      ];
    };
    "/var/log" = {
      device = systemFileDevice;
      fsType = "btrfs";
      options = [
        "subvol=@log"
        "noatime"
        "compress=zstd"
      ];
    };
    "/.swap" = {
      device = systemFileDevice;
      fsType = "btrfs";
      options = [
        "subvol=@swap"
        "nodatacow"
      ];
    };
  };
  # 交换设备和交换文件
  swapDevices = [
    {
      device = "/.swap/swapfile";
      size = 16384;
    }
  ];
  # 指定 Nixpkgs 编译和打包时使用的主机平台架构
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  # 启用 AMD CPU 微码更新, 从可分发的固件中加载更新
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
