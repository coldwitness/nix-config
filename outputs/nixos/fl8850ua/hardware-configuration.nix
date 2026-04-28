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
  # 硬件自动检测模块, 会根据当前硬件生成相应的内核模块列表, 并处理一些特定硬件的配置
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];
  # 启动相关配置
  boot = {
    # Linux 内核
    kernelPackages =
      let
        # 定义一个函数, 用于构建自定义的内核包
        linux_lqx_pkg =
          { fetchurl, buildLinux, ... }@args:
          #  调用 buildLinux 函数, 传入参数并覆盖部分属性
          buildLinux (
            args
            // rec {
              # 内核主版本号
              version = "7.0.2";
              # 模块目录版本
              modDirVersion = "${version}-zen1";
              # 内核源代码的获取方式
              src = pkgs.fetchurl {
                url = "https://github.com/zen-kernel/zen-kernel/archive/refs/tags/v${modDirVersion}.tar.gz";
                sha256 = "sha256-G4NnmTeQK9egBFSSjqUfiFIlHf7kIr6pMwCoFRhwgsw=";
              };
              # 额外的内核补丁列表
              kernelPatches = [ ];
              #  添加内核包的元数据, 设置分支名便于识别
              extraMeta.branch = version;
              # 允许通过 argsOverride 进一步覆盖参数
            }
            // (args.argsOverride or { })
          );
        #  使用 pkgs.callPackage 调用上面定义的函数, 自动解析并传入所需的依赖
        linux_lqx = pkgs.callPackage linux_lqx_pkg { };
      in
      # 根据自定义内核生成完整的内核包集合
      # 然后使用 recurseIntoAttrs 让该属性集在 nix-env 等命令中被正确展开
      lib.recurseIntoAttrs (pkgs.linuxPackagesFor linux_lqx);
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
  swapDevices = [ { device = "/.swap/swapfile"; } ];
  # 指定 Nixpkgs 编译和打包时使用的主机平台架构
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  # 启用 AMD CPU 微码更新, 从可分发的固件中加载更新
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
