{
  ...
}:
let
  vars = import ../../../../vars;
  opts = {
    # nix-config 仓库本身所在路径
    nixConfigPath = "/home/admin/workspace/nix-config";
  # ========== Users 模块 - 用户配置 ==========
    users = {
      root = {
        # 哈希密码
        hashedPassword = "$6$a46xJM8CZ80Jplk2$BiG06wUNzicRYKStqIh0vV2ZE87NHQyvh27jD.gJawiu8wGrFw6zNunzpNb7aXhjyU.4x/UZZvFT05rEAjzGT0";
      };
      admin = {
        # 普通用户
        isNormalUser = true;
        # 用户描述
        description = "管理员";
        # 添加用户到额外组
        extraGroups = [
          "wheel"
          "networkmanager"
        ];
        hashedPassword = "$6$a46xJM8CZ80Jplk2$BiG06wUNzicRYKStqIh0vV2ZE87NHQyvh27jD.gJawiu8wGrFw6zNunzpNb7aXhjyU.4x/UZZvFT05rEAjzGT0";
      };
    };
  # ========== CLI 工具模块 - 命令行实用工具 ==========
    cli = {
      # Nix CLI 助手, 自动清理旧一代系统配置
      nh.enable = true;
      # cat 替代品, 带语法高亮和行号
      bat.enable = false;
      # ls 替代品, 现代文件列表工具
      eza.enable = false;
      # 命令行模糊搜索工具
      fzf.enable = false;
      # 分布式版本控制系统
      git.enable = true;
      # 安全远程登录客户端
      ssh.enable = false;
      # 命令运行器, 类似 Makefile
      just.enable = true;
      # 终端复用器, 可在一个终端中运行多个会话
      tmux.enable = false;
      # 用 Rust 编写的快速文件管理器
      yazi.enable = true;
      # 系统资源监控器
      btop.enable = false;
      # NVIDIA GPU 监控工具
      nvitop.enable = false;
      # 跨 Shell 的提示符定制工具
      starship.enable = true;
      # 类似 Neofetch 但更快的系统信息工具
      fastfetch.enable = false;
      # AI 编程助手
      opencode.enable = false;
      # NixOS MCP
      mcp-nixos.enable = false;
      # Nix 包管理器配置
      nix.substituters = [
        # 上海交大镜像源
        "https://mirror.sjtu.edu.cn/nix-channels/store"
        # 中科大镜像源
        # "https://mirrors.ustc.edu.cn/nix-channels/store"
        # 清华镜像源
        # "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
        # 默认官方源
        "https://cache.nixos.org"
      ];
    };
  # ========== Tool 模块 - 实用工具 ==========
    tool = {
      # 模块化输入法框架, 支持多种输入法
      fcitx5.enable = true;
      # 游戏逆向工程工具(Linux 版 Cheat Engine)
      pince.enable = false;
      # Linux 游戏平台管理工具
      lutris.enable = false;
      # 办公套件
      onlyoffice.enable = false;
      # Clash 代理客户端
      clash-verge.enable = false;
      # GUI 系统活动监控器
      mission-center.enable = false;
    };
  # ========== i18n 模块 - 本地化和语言 ==========
    i18n = {
      # 语言环境, 可选项:
      # en-us
      # zh-cn
      locale = vars.localeTypes.zh-cn;
    };
  # ========== Media 模块 - 媒体应用 ==========
    media = {
      # 轻量级视频播放器
      mpv.enable = false;
      # 录屏和直播软件
      obs-studio.enable = false;
    };
  # ========== Editor 模块 - 编辑器配置 ==========
    editor = {
      # Neovim 的 Nix 配置
      nixvim.enable = false;
      # Visual Studio Code
      vscode.enable = false;
    };
  # ========== Shell 模块 - 命令解释器 ==========
    shell = {
      # 用户友好的命令行 shell
      fish.enable = true;
    };
  # ========== Desktop 模块 - 桌面环境 ==========
    desktop = {
      # 桌面类型, 可选项:
      # disable(不启用桌面, 这将连带禁用所有图形应用)
      # hyprland
      type = vars.desktopTypes.hyprland;
      # DankMaterialShell
      dms = {
        enable = true;
        # 软件渲染模式(用于无 GPU 或虚拟化环境)
        softwareRenderingEnable = false;
      };
    };
  # ========== Terminal 模块 - 终端模拟器 ==========
    terminal = {
      # 轻量级终端模拟器
      foot.enable = false;
      # 跨平台 GPU 加速终端模拟器
      kitty.enable = true;
    };
  # ========== Service 模块 - 系统服务 ==========
    service = {
      # 内网穿透工具
      frp.enable = false;
      # HTTP 和反向代理 web 服务器
      nginx.enable = false;
      # 轻量级登录管理器
      greetd.enable = true;
      # 系统登录和电源管理
      logind.enable = false;
      # SSH 服务器
      openssh.enable = true;
      # Btrfs 快照管理工具
      snapper.enable = false;
      # U 盘自动挂载服务
      udiskie.enable = false;
      # 多媒体框架, 替代 PulseAudio
      pipewire.enable = true;
      # 输入设备驱动服务
      libinput.enable = true;
      # 通用代理工具
      sing-box.enable = false;
      # P2P VPN 服务
      zerotierone.enable = false;
      # 远程桌面服务器
      rustdesk-server.enable = false;
    };
  # ========== Internet 模块 - 网络应用 ==========
    internet = {
      # 腾讯 QQ
      qq.enable = false;
      # 微信
      wechat.enable = false;
      # 火狐浏览器
      firefox.enable = false;
      # 远程桌面客户端
      rustdesk.enable = false;
      # 即时通讯应用
      telegram-desktop.enable = false;
    };
  # ========== Hardware 模块 - 硬件配置 ==========
    hardware = {
      # 内存压缩配置
      zram.enable = false;
      # 蓝牙配置
      bluetooth.enable = false;
      # 图形驱动配置
      graphics = {
        # 启用硬件加速
        enable = false;
        # 启用 32 位驱动(Wine 等)
        enable32Bit = false;
        # GPU 类型, 可选项:
        # none(默认)
        # amd
        type = vars.gpuTypes.none;
      };
      # 网络配置
      networking = {
        # 主机名
        hostName = "default-x86-64";
        # 网络连接管理
        networkmanager.enable = true;
        # 防火墙
        firewall = {
          enable = false;
          # 在防火墙中打开的端口
          # allowedTCPPorts = [ ... ];
          # allowedUDPPorts = [ ... ];
        };
        # 网络代理
        proxy = {
          # default = "http://user:password@proxy:port/";
          # noProxy = "127.0.0.1,localhost,internal.domain";
        };
      };
      boot-loader = {
        # EFI 系统分区挂载点
        efiSysMountPoint = "/boot";
        # 启动加载器, 可选项:
        # systemd-boot(默认)
        # grub(目前未实现)
        type = vars.bootLoaderTypes.systemd-boot;
      };
    };
  # ========== Container 模块 - 容器管理 ==========
    container = {
      # 容器引擎, Docker 替代品
      podman.enable = false;
      # Portainer 代理
      portainer-agent.enable = false;
    };
  };
in
opts
