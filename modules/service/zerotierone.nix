{
  lib,
  inputs,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.service.zerotierone or { };
  finallyEnable = cfg.enable or false;
  settings = if builtins.pathExists "${inputs.secrets}/zerotierone" 
             then import "${inputs.secrets}/zerotierone" 
             else { };
  joinNetworks = settings.joinNetworks or [ ];
in
{
  config = lib.mkIf finallyEnable {
    services.zerotierone ={
      enable = true;
      inherit joinNetworks;
    };
  };
}
