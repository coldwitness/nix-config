{
  inputs,
  ...
}:
let
  # 从 vars/ 导入类型定义
  inherit (import ../../../vars) localeTypes desktopTypes bootLoaderTypes;
  hostOptions = {
    # 命令行模块
    cli = {
      nh.enable = true;
      bat.enable = true;
      eza.enable = true;
      fzf.enable = true;
      git.enable = true;
      ssh.enable = true;
      tmux.enable = true;
      yazi.enable = true;
      btop.enable = true;
      pince.enable = false;
      opencode.enable = false;
      starship.enable = true;
      fastfetch.enable = true;
      mcp-nixos.enable = false;
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
      locale = localeTypes.en-us;
    };
    # 工具模块
    tool = {
      fcitx5.enable = false;
      lutris.enable = false;
      onlyoffice.enable = false;
    };
    # 命令解释器模块
    shell = {
      fish.enable = true;
    };
    # 多媒体模块
    media = {
      mpv.enable = false;
      obs-studio.enable = false;
    };
    # 编辑器模块
    editor = {
      vscode.enable = false;
      nixvim.enable = false;
    };
    # 后台服务模块
    service = {
      ssh.enable = true;
      greetd.enable = false;
      logind.enable = false;
      snapper.enable = false;
      udiskie.enable = false;
      pipewire.enable = false;
      libinput.enable = false;
      sing-box.enable = false;
      zerotierone.enable = false;
      frp = {
        enable = false;
        settings = import "${inputs.secrets}/frp";
      };
    };
    # 桌面模块
    desktop = {
      type = desktopTypes.disable;
      dms.enable = false;
    };
    # 终端模块
    terminal = {
      kitty.enable = false;
    };
    # 硬件模块
    hardware = {
      zram.enable = true;
      bluetooth.enable = false;
      boot-loader = {
        type = bootLoaderTypes.systemd-boot;
        efiSysMountPoint = "/boot/efi";
      };
      network = {
        # 域名
        domain = "";
        # 设置主机名
        hostName = "ALC";
        # 防火墙
        firewall = {
          enable = false;
          # 在防火墙中打开端口
          # allowedTCPPorts = [ ... ];
          # allowedUDPPorts = [ ... ];
        };
        # 网络代理
        # proxy = {
        #   default = "http://localhost:2334/";
        #   noProxy = "127.0.0.1,localhost,internal.domain";
        # };
      };
    };
    # 上网工具模块
    internet = {
      qq.enable = false;
      wechat.enable = false;
      firefox.enable = false;
      rustdesk.enable = false;
      telegram-desktop.enable = false;
    };
    # 容器模块
    container = {
      enable = true;
      portainer-agent.enable = false;
      rustdesk-server.enable = true;
    };
  };
in
hostOptions
