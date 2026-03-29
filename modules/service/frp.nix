{
  lib,
  inputs,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.service.frp or { };
  finallyEnable = cfg.enable or false;
  instance = cfg.instance or { };
in
{

  config = lib.mkIf finallyEnable {
    services.frp = {
      instances = {
        inherit instance;
      };
    };
  };
}
