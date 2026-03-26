{
  lib,
  pkgs,
  config,
  modulesPath,
  ...
}:
let
  systemBootDevice = "/dev/disk/by-uuid/027B-7471";
  systemFileDevice = "/dev/disk/by-uuid/8c18bbfc-4114-497a-b34b-760429d94a25";
in 
{
  imports = [
    # 导入 NixOS 官方提供的硬件自动检测模块, 会根据当前硬件生成相应的内核模块列表, 并处理一些特定硬件的配置
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    # 覆盖 NixOS 使用的 Linux 内核
    kernelPackages = pkgs.linuxPackagesFor (
      pkgs.linux_zen.override {
        argsOverride = rec {
          version = "6.19.9";
          modDirVersion = "${version}-lqx1";
          src = pkgs.fetchurl {
            url = "https://github.com/zen-kernel/zen-kernel/archive/refs/tags/v${modDirVersion}.tar.gz";
            sha256 = "sha256-v0F+Czl7lcLxSI7lZl1A0MymjLiCnVeaBixfyiWGU0U=";
          };
          # 添加内核配置覆盖
          kernelConfig = {
            # 强制启用完全抢占
            PREEMPT = "y";
            # 确保其他抢占模型被禁用
            PREEMPT_NONE = "n";
            PREEMPT_VOLUNTARY = "n";
          };
        };
      }
    );
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
      "kvm-amd"
    ];
    # 提供内核模块的附加软件包列表
    extraModulePackages = with config.boot.kernelPackages; [ ];
  };
  # 要挂载的文件系统
  fileSystems = {
    "/boot" = {
      device = systemBootDevice;
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };
    "/" = {
      device = systemFileDevice;
      fsType = "btrfs";
      options = [ "subvol=@" ];
    };
    "/.snapshots" = {
      device = systemFileDevice;
      fsType = "btrfs";
      options = [ "subvol=@snapshots" ];
    };
    "/home" = {
      device = systemFileDevice;
      fsType = "btrfs";
      options = [ "subvol=@home" ];
    };
    "/home/.snapshots" = {
      device = systemFileDevice;
      fsType = "btrfs";
      options = [ "subvol=@home-snapshots" ];
    };
    "/nix" = {
      device = systemFileDevice;
      fsType = "btrfs";
      options = [ "subvol=@nix" ];
    };
    "/var/log" = {
      device = systemFileDevice;
      fsType = "btrfs";
      options = [ "subvol=@log" ];
    };
    "/.swap" = {
      device = systemFileDevice;
      fsType = "btrfs";
      options = [ "subvol=@swap" ];
    };
  };
  # 交换设备和交换文件
  swapDevices = [ { device = "/.swap/swapfile"; } ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
