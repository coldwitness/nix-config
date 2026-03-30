{
  lib,
  inputs,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.service.frp or { };
  finallyEnable = cfg.enable or false;
  settingsFile = "${inputs.secrets}/frp/${hostOptions.hardware.networking.hostName}.nix";
  settings = if builtins.pathExists settingsFile 
             then import settingsFile
             else { };
  instances = settings.instances or { };
in
{
  config = lib.mkIf finallyEnable {
    services.frp = {
      inherit instances;
    };
  };
}
