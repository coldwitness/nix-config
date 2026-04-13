{
  lib,
  opts,
  inputs,
  ...
}:
let
  cfg = opts.service.zerotierone or { };
  finallyEnable = cfg.enable or false;
  joinNetworks = cfg.joinNetworks or [ ];
in
{
  config = lib.mkIf finallyEnable {
    services.zerotierone = {
      enable = true;
      inherit joinNetworks;
    };
  };
}
