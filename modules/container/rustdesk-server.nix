{
  lib,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.container.rustdesk-server;
  finallyEnable = cfg.enable && hostOptions.container.enable;
in
{
  config = lib.mkIf finallyEnable {
    virtualisation.oci-containers.containers = {
      rustdesk-server-hbbr = {
        image = "rustdesk/rustdesk-server:latest";
        cmd = [ "hbbr" ];
        volumes = [
          "/root/workspace/docker/rustdesk-server:/root"
        ];
        # 在容器停止或被杀死时自动移除(禁用，否则与 --restart 参数冲突)
        autoRemoveOnStop = false;
        # 使用 host 网络模式
        extraOptions = [
          "--network=host"
          "--restart=unless-stopped"
        ];
      };
      rustdesk-server-hbbs = {
        image = "rustdesk/rustdesk-server:latest";
        cmd = [ "hbbs" ];
        volumes = [
          "/root/workspace/docker/rustdesk-server:/root"
        ];
        # 在容器停止或被杀死时自动移除(禁用，否则与 --restart 参数冲突)
        autoRemoveOnStop = false;
        extraOptions = [
          "--network=host"
          "--restart=unless-stopped"
        ];
        # 确保 hbbs 在 hbbr 之后启动
        dependsOn = [ "rustdesk-server-hbbr" ];
      };
    };
  };
}
