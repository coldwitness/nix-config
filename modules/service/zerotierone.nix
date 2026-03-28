{
  lib,
  inputs,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.service.zerotierone;
  finallyEnable = cfg.enable;
  settings = import "${inputs.secrets}/zerotierone";
in
{
  config = lib.mkIf finallyEnable {
    services.zerotierone ={
      enable = true;
      joinNetworks = settings.joinNetworks;
    };
  };
}
