{
  inputs,
  ...
}:
let
  vars = import ../../../vars;
  hostOptions = {
    # 命令行模块
    cli = {
      nh.enable = true;
      bat.enable = true;
      eza.enable = true;
      fzf.enable = true;
      git.enable = true;
      ssh.enable = true;
      just.enable = true;
      tmux.enable = true;
      yazi.enable = true;
      btop.enable = true;
      starship.enable = true;
      fastfetch.enable = true;
      nix.substituters = [
        "https://mirror.sjtu.edu.cn/nix-channels/store"
        # 添加中科大镜像源
        # "https://mirrors.ustc.edu.cn/nix-channels/store"
        # 清华大学镜像源
        # "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
        # 默认官方源
        "https://cache.nixos.org"
      ];
    };
    # 本地化模块
    i18n = {
      locale = vars.localeTypes.zh-cn;
    };
    # 工具模块
    tool = {
      fcitx5.enable = true;
    };
    # 命令解释器模块
    shell = {
      fish.enable = true;
    };
    # 后台服务模块
    service = {
      greetd.enable = true;
      pipewire.enable = true;
      libinput.enable = true;
    };
    # 桌面模块
    desktop = {
      type = vars.desktopTypes.hyprland;
      dms.enable = true;
    };
    # 终端模块
    terminal = {
      kitty.enable = true;
    };
    # 硬件模块
    hardware = {
      boot-loader = {
        type = vars.bootLoaderTypes.systemd-boot;
        efiSysMountPoint = "/boot";
      };
      networking = {
        # 设置主机名
        hostName = "nixos";
        # 是否使用 NetworkManager 为所有未手动配置的网络接口获取 IP 地址和其他配置
        networkmanager.enable = true;
        # 防火墙
        firewall = {
          enable = false;
          # 在防火墙中打开端口
          # allowedTCPPorts = [ ... ];
          # allowedUDPPorts = [ ... ];
        };
      };
    };
  };
in
hostOptions
