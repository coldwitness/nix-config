{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
  ];

  # Podman 配置
  virtualisation ={
    podman = {
      enable = true;
      # 创建一个别名映射 docker 到 podman
      # dockerCompat = true;
      # 将 Podman 套接字用于代替 Docker 套接字
      dockerSocket.enable = true;
    };
    # 指定 oci-containers 使用 podman 后端
    oci-containers.backend = "podman";
  };
  # 配置 Cockpit Web 管理界面
  services.cockpit = {
    enable = true;
    port = 9090;
    plugins = with pkgs; [
      cockpit-podman
    ];
  };
}
