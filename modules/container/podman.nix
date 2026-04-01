{
  lib,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.container or { };
  finallyEnable = cfg.enable or false;
in
{
  config = lib.mkIf finallyEnable {
    virtualisation = {
      # Podman 配置
      podman = {
        enable = true;
        # 创建一个别名映射 docker 到 podman
        dockerCompat = false;
        # 将 Podman 套接字用于代替 Docker 套接字
        dockerSocket.enable = true;
      };
      # 指定 oci-containers 使用 podman 后端
      oci-containers.backend = "podman";
    };
  };
}
