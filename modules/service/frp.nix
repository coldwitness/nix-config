{
  lib,
  inputs,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.service.frp;
  finallyEnable = cfg.enable;
in
{

  config = lib.mkIf finallyEnable {
    services.frp = {
      instances = {
        client = {
          enable = true;
          role = "client";
          settings = cfg.settings;
        };
      };
    };
  };
}
