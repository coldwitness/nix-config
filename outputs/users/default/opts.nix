{
  inputs,
  ...
}:
let
  vars = import ../../../vars { inherit inputs; };
  optSets = import ../../optSets { inherit inputs; };
  functions = import ../../../functions { inherit inputs; };
  # 预定义选项集列表
  predefinedOptSetsList = [
    # 按需启用
  ];
  # 自定义选项集
  customOptSets = {
    # nix-config 仓库本身所在路径
    nixConfigPath = "/path/to/nix-config";
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
      yazi.enable = false;
      # 系统资源监控器
      btop.enable = false;
      # NVIDIA GPU 监控工具
      nvitop.enable = false;
      # 跨 Shell 的提示符定制工具
      starship.enable = false;
      # 类似 Neofetch 但更快的系统信息工具
      fastfetch.enable = false;
      # AI 编程助手
      opencode.enable = false;
      # NixOS MCP
      mcp-nixos.enable = false;
      # nix 文件批量格式化工具
      nixfmt-tree.enable = true;
    };
    # ========== Tool 模块 - 实用工具 ==========
    tool = {
      # 模块化输入法框架, 支持多种输入法
      fcitx5.enable = false;
      # 游戏逆向工程工具(Linux 版 Cheat Engine)
      pince.enable = false;
      # Linux 游戏平台管理工具
      lutris.enable = false;
      # 办公套件
      onlyoffice.enable = false;
      # GUI 系统活动监控器
      mission-center.enable = false;
    };
    # ========== i18n 模块 - 本地化和语言 ==========
    i18n = {
      # 语言环境, 可选项:
      # en-us
      # zh-cn
      locale = vars.localeTypes.en-us;
    };
    # ========== Media 模块 - 媒体应用 ==========
    media = {
      # 轻量级视频播放器
      mpv.enable = false;
      # Spotify 音乐播放器
      spotify.enable = false;
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
      fish.enable = false;
    };
    # ========== Terminal 模块 - 终端模拟器 ==========
    terminal = {
      # 轻量级终端模拟器
      foot.enable = false;
      # 跨平台 GPU 加速终端模拟器
      kitty.enable = false;
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
      # 图形驱动配置
      graphics = {
        # GPU 类型, 可选项:
        # none(默认)
        # amd
        type = vars.gpuTypes.none;
      };
    };
  };
  opts = functions.mergeOptSetsList customOptSets predefinedOptSetsList;
in
opts
