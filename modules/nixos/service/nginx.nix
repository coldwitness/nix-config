{
  lib,
  opts,
  ...
}:
let
  cfg = opts.service.nginx or { };
  finallyEnable = cfg.enable or false;
in
{
  config = lib.mkIf finallyEnable {
    services.nginx = {
      enable = true;
    };
  };
}
