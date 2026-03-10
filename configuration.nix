{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
      # 导入硬件配置模块, 用于加载硬件扫描结果
      ./hardware-configuration.nix
    ];

  # 引导加载器配置
  boot.loader = {
    # 启用 systemd-boot 引导程序
    systemd-boot.enable = true;
    # 允许修改 EFI 变量, 支持 UEFI 引导
    efi.canTouchEfiVariables = true;
  };

  # 网络配置
  networking = {
    # 设置主机名
    hostName = "nixos";
    # 启用 NetworkManager, 支持无线网络管理
    networkmanager.enable = true;
    # 在防火墙中打开端口
    firewall = {
      # 完全关闭防火墙
      enable = false;
      # allowedTCPPorts = [ ... ];
      # allowedUDPPorts = [ ... ];
    };
    # 网络代理
    proxy = {
      default = "http://localhost:2334/";
      noProxy = "127.0.0.1,localhost,internal.domain";
    };
  };

  # Nix 包管理器配置
  nix.settings = {
    substituters = [
    "https://mirror.sjtu.edu.cn/nix-channels/store"
    # 添加中科大镜像源
    "https://mirrors.ustc.edu.cn/nix-channels/store"
    # 清华大学镜像源
    "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
    # 默认官方源
    "https://cache.nixos.org"
    ];
    # 启用实验性功能
    experimental-features = [
      # nix 命令增强
      "nix-command"
      # flakes 支持
      "flakes"
    ];
  };

  # Nixpkgs 配置
  nixpkgs.config = {
    # 允许安装非自由软件包
    allowUnfree = true;  
  };

  # 用户账户配置
  users = {
    # 开启完全声明式管理
    mutableUsers = false;
    # 用户配置
    users = {
      root = {
      # 哈希密码
      hashedPassword = "$6$yk.jU.kxIAVwaoaj$zFEdwFofY8P88Ad7/a62sm5j3QxyXcQxKTvTpRMIYDgw6G4RDXZCQgHRyeOyZHLN10lKov55WJESL8t2Ia1US0";
    };
      admin = {
        # 普通用户
      isNormalUser = true;
      # 用户描述
      description = "管理员";
      # 添加用户到额外组
      extraGroups = [
        "wheel"
        "podman"
        "networkmanager"
      ];
      hashedPassword = "$6$Yq2f2308VGQlSDxb$v6tOVrxDvVJYSB40g8t/n2ZVw9pSARf5Gxe.ph2n.TvyXDPiruSi8Y9pEuPNi0regGL8AB8dQBmge/kNTZqxh1";
      };
    };
  };

  # 系统级包列表
  environment.systemPackages = with pkgs; [
    git
  ];

  # 服务配置
  services = {
    # 启用触摸板支持(在大多数桌面管理器中默认启用)
    libinput.enable = true;
    # 禁用 PulseAudio(使用 PipeWire 替代)
    pulseaudio.enable = false;  
    # 启用 PipeWire 多媒体框架
    pipewire = {
      enable = true;
      # 启用 PipeWire 的 ALSA 兼容层
      alsa.enable = true;
      # 支持 32 位 ALSA 应用
      alsa.support32Bit = true;
      # 启用 PulseAudio 兼容层
      pulse.enable = true;
    };
    # 启用 CUPS 打印服务以打印文档
    # printing.enable = true;
    # 启用 OpenSSH 守护进程
    openssh.enable = true;
    # 合盖管理
    logind.settings.Login = {
      HandleLidSwitchExternalPower = "ignore";
      HandleLidSwitchDocked = "ignore";
      HandleLidSwitch = "ignore";
    };
  };

  # 指定 NixOS 状态版本(保持为首次安装版本)
  system.stateVersion = "25.11";
}
