{
  lib,
  inputs,
  pkgs-unstable,
  ...
}:
let
  # 从 vars/ 导入类型定义
  vars = import ../../../vars;
  inherit (vars) localeTypes systemTypes desktopTypes;
  system = systemTypes.x86_64-linux;

  # 平台级选项配置
  hostConfig = {
    # 命令行模块
    cli = {

    };
    # 本地化模块
    i18n = {
      locale = localeTypes.zh-cn;
    };
    # 工具模块
    tool = {
      fcitx5.enable = true;
      lutris.enable = true;
      onlyoffice.enable = false;
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
      nixvim.enable = false;
    };
    # 后台服务模块
    service = {

    };
    # 桌面模块
    desktop = {
      type = desktopTypes.hyprland;
      dms.enable = true;
    };
    # 终端模块
    terminal = {
      kitty.enable = true;
    };
    # 硬件模块
    hardware = {
      system = system;
      zram.enable = true;
      bluetooth.enable = true;
      network = {
        enable = true;
        # 设置主机名
        hostName = "FL8850UA";
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
    # 容器模块
    container = {
      enable = false;
      portainer-agent.enable = false;
    };
  };
in
{
  inherit hostConfig;

  nixosConfigurations = {
    FL8850UA = lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit inputs pkgs-unstable;
        inherit hostConfig;
      };
      modules = [
        {
          # 允许安装非自由软件包
          nixpkgs.config.allowUnfree = true;
          # NixOS 首次安装的版本
          system.stateVersion = "25.11";
        }
        ../../../users
        ../../../modules
        ./hardware-configuration.nix
        inputs.nur.modules.nixos.default
      ];
    };
  };
}
