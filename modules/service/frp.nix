{
  lib,
  opts,
  config,
  inputs,
  ...
}:
let
  cfg = opts.service.frp or { };
  enableSopsNix = opts.service.spos-nix.enable or false;
  finallyEnable = cfg.enable or false && enableSopsNix;
  role = cfg.role or "server";
  proxies = cfg.proxies or [ ];
in
{
  config = lib.mkIf finallyEnable {
    sops.secrets."frp.env" = {
      sopsFile = ../../secrets/frp.env;
      format = "dotenv";
      owner = "root";
      group = "root";
      mode = "0400";
    };
    services.frp.instances.${role} = lib.mkMerge [
      {
        enable = true;
        inherit role;
        environmentFiles = [ config.sops.secrets."frp.env".path ];
        settings = {
          auth = {
            method = "token";
            token = "{{ .Envs.TOKEN }}";
          };
          log.level = "warn";
        };
      }
      # 服务端特有配置
      (lib.mkIf (role == "server") {
        settings = {
          bindAddr = "0.0.0.0";
          bindPort = 7000;
          webServer = {
            addr = "0.0.0.0";
            port = 21126;
            user = "{{ .Envs.USER }}";
            password = "{{ .Envs.TOKEN }}";
          };
        };
      })
      # 客户端特有配置
      (lib.mkIf (role == "client") {
        settings = {
          serverAddr = "{{ .Envs.ADDR }}";
          serverPort = 7000;
          inherit proxies;
        };
      })
    ];
  };
}
