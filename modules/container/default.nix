{
  ...
}:
let
  containerPath = "/home/admin/workspace/nix-config/secrets/containers";
in
{
  imports = [
    ./portainer-agent.nix
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
}
