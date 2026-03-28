{
  lib,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.service.ssh;
  finallyEnable = cfg.enable;
in
{
  config = lib.mkIf finallyEnable {
    services = {
      openssh.enable = true;
    };
  };
}
