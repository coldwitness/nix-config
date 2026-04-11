{
  lib,
  opts,
  inputs,
  ...
}:
let
  cfg = opts.service.zerotierone or { };
  finallyEnable = cfg.enable or false;
  settingsFile = "${inputs.secrets}/zerotierone";
  settings =
    if builtins.pathExists settingsFile 
    then import settingsFile
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
