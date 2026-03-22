{
  lib,
  hostConfig,
  ...
}:
let
  cfg = hostConfig.hardware.network;
  finallyEnable = cfg.enable;
in
{
  config = lib.mkIf finallyEnable {
    networking = {
      hostName = cfg.hostName;
      networkmanager.enable = true;
      firewall = cfg.firewall;
      proxy = cfg.proxy;
    };
  };
}
