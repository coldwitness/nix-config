{
  ...
}:
{
  # 网络配置
  networking = {
    # 设置主机名
    hostName = "nixos";
    # 在防火墙中打开端口
    firewall = {
      # 完全关闭防火墙
      enable = false;
      # allowedTCPPorts = [ ... ];
      # allowedUDPPorts = [ ... ];
    };
    # 网络代理
    # proxy = {
    #   default = "http://user:password@proxy:port/";
    #   noProxy = "127.0.0.1,localhost,internal.domain";
    # };
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
  # 用户账户配置
  users = {
    # 开启完全声明式管理
    mutableUsers = false;
    # 用户配置
    users = {
      root = {
      # 哈希密码(默认 passwd)
      hashedPassword = "$6$a46xJM8CZ80Jplk2$BiG06wUNzicRYKStqIh0vV2ZE87NHQyvh27jD.gJawiu8wGrFw6zNunzpNb7aXhjyU.4x/UZZvFT05rEAjzGT0";
    };
      admin = {
        # 普通用户
      isNormalUser = true;
      # 添加用户到额外组
      extraGroups = [
        "wheel"
        "networkmanager"
      ];
      hashedPassword = "$6$a46xJM8CZ80Jplk2$BiG06wUNzicRYKStqIh0vV2ZE87NHQyvh27jD.gJawiu8wGrFw6zNunzpNb7aXhjyU.4x/UZZvFT05rEAjzGT0";
      };
    };
  };
  # 启用 git
  programs.git.enable = true;
  # 启用 OpenSSH 守护进程
  services.openssh.enable = true;
}
