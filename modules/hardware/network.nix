{
  ...
}:
{
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
}
