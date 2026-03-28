{
  lib,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.hardware.network;
  finallyEnable = cfg.enable;
in
{
  config = lib.mkIf finallyEnable {
    networking = {
      hostName = cfg.hostName;
      networkmanager.enable = true;
      firewall = cfg.firewall;
      proxy = cfg.proxy or { };
    };
  };
}
