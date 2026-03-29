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
    # 命令解释器模块
    shell = {
      fish.enable = true;
    };
    # 后台服务模块
    service = {
      openssh.enable = true;
      rustdesk-server = {
        enable = true;
        inherit (import "${inputs.secrets}/rustdesk-server") relayHosts;
      };
      frp = {
        enable = true;
        instance = import "${inputs.secrets}/frp/ALC.nix";
      };
    };
    # 硬件模块
    hardware = {
      zram.enable = true;
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
  };
in
hostOptions
