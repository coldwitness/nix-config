{ config, lib, pkgs, ... }:

{
  imports = [
      # 包含硬件扫描的结果
      ./hardware-configuration.nix
    ];

  # 使用 systemd-boot EFI 引导加载程序
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking.hostName = "nixos"; # 定义主机名

  # 使用 nmcli 或 nmtui 交互式配置网络连接
  networking.networkmanager.enable = true;

  # 设置时区
  # time.timeZone = "Europe/Amsterdam";

  # 如有需要，配置网络代理
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # 选择国际化属性
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # 启用 X11 窗口系统
  # services.xserver.enable = true;

  # 在 X11 中配置键盘布局
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # 启用 CUPS 打印服务以打印文档
  # services.printing.enable = true;

  # 启用声音
  # services.pulseaudio.enable = true;
  # 或者
  # services.pipewire = {
  #   enable = true;
  #   pulse.enable = true;
  # };

  # 启用触摸板支持(在大多数桌面管理器中默认启用)
  # services.libinput.enable = true;

  # 定义用户账户
  # users.users.alice = {
  #   isNormalUser = true;
  #   extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  #   packages = with pkgs; [
  #     tree
  #   ];
  # };

  # programs.firefox.enable = true;

  # 列出系统配置文件中安装的软件包
  # 您可以使用 https://search.nixos.org/ 来查找更多软件包(和选项)
  # environment.systemPackages = with pkgs; [
  #   vim
  #   wget
  # ];

  # 某些程序需要 SUID 包装器, 可以进一步配置或在用户会话中启动
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # 列出您想要启用的服务：

  # 启用 OpenSSH 守护进程。
  # services.openssh.enable = true;

  # 在防火墙中打开端口
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # 或者完全关闭防火墙
  # networking.firewall.enable = false;

  # 复制 NixOS 配置文件并将其链接到生成的系统(/run/current-system/configuration.nix)
  # 这在您不小心删除 configuration.nix 时非常有用
  # system.copySystemConfiguration = true;

  system.stateVersion = "25.11";
}
