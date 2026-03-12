{
  containerPath,
  ...
}:
{
  virtualisation.oci-containers.containers = {
    portainer-agent = {
      image = "portainer/agent:latest";
      ports = [
        "9001:9001"
      ];
      volumes = [
        "/:/host"
        "/run/podman/podman.sock:/var/run/docker.sock"
        "/var/lib/containers/storage/volumes:/var/lib/docker/volumes"
      ];
      # 在容器停止或被杀死时自动移除(禁用，否则与 --restart 参数冲突)
      autoRemoveOnStop = false;
      # podman run 的额外选项
      extraOptions = [
        "--restart=unless-stopped"
      ];
    };
    frpc = {
      image = "fatedier/frpc:v0.67.0";
      volumes = [
        "${containerPath}/service-core/frpc/frpc.toml:/frpc.toml"
        "${containerPath}/service-core/frpc/frpc.log:/frpc.log"
      ];
      environment = {
        TZ = "Asia/Shanghai";
      };
      cmd = [
        "-c"
        "/frpc.toml"
      ];
      autoRemoveOnStop = false;
      extraOptions = [
        "--network=host"
        "--restart=unless-stopped"
      ];
    };
  };
}
