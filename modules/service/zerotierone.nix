{
  lib,
  inputs,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.service.zerotierone or { };
  finallyEnable = cfg.enable or false;
  inherit (import "${inputs.secrets}/zerotierone") joinNetworks;
in
{
  config = lib.mkIf finallyEnable {
    services.zerotierone ={
      enable = true;
      inherit joinNetworks;
    };
  };
}
