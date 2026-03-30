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
      opencode.enable = true;
      starship.enable = true;
      fastfetch.enable = true;
      mcp-nixos.enable = true;
      nix.substituters = [
      # "https://mirror.sjtu.edu.cn/nix-channels/store"
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
      pince.enable = true;
      fcitx5.enable = true;
      lutris.enable = true;
    };
    # 命令解释器模块
    shell = {
      fish.enable = true;
    };
    # 多媒体模块
    media = {
      mpv.enable = true;
      obs-studio.enable = true;
    };
    # 编辑器模块
    editor = {
      vscode.enable = true;
    };
    # 后台服务模块
    service = {
      frp.enable = true;
      greetd.enable = true;
      logind.enable = true;
      openssh.enable = true;
      snapper.enable = true;
      udiskie.enable = true;
      pipewire.enable = true;
      libinput.enable = true;
      sing-box.enable = true;
      zerotierone.enable = true;
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
      zram.enable = true;
      bluetooth.enable = true;
      boot-loader = {
        type = vars.bootLoaderTypes.systemd-boot;
        efiSysMountPoint = "/boot";
      };
      networking = {
        # 设置主机名
        hostName = "FL8850UA";
        # 是否使用 NetworkManager 为所有未手动配置的网络接口获取 IP 地址和其他配置
        networkmanager.enable = true;
        # 防火墙
        firewall = {
          enable = false;
          # 在防火墙中打开端口
          # allowedTCPPorts = [ ... ];
          # allowedUDPPorts = [ ... ];
        };
        # 网络代理
        proxy = {
          default = "http://localhost:2334/";
          noProxy = "127.0.0.1,localhost,internal.domain";
        };
      };
      graphics = {
        enable = true;
        enable32Bit = true;
        type = vars.gpuTypes.amd;
      };
    };
    # 上网工具模块
    internet = {
      qq.enable = true;
      wechat.enable = true;
      firefox.enable = true;
      rustdesk.enable = true;
      telegram-desktop.enable = true;
    };
  };
in
hostOptions
