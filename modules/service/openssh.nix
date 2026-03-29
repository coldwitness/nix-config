{
  lib,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.service.openssh or { };
  finallyEnable = cfg.enable or false;
in
{
  config = lib.mkIf finallyEnable {
    services = {
      openssh.enable = true;
    };
  };
}
