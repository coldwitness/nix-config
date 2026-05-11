{
  lib,
  pkgs,
  opts,
  inputs,
  ...
}:
let
  cfg = opts.service.openlist or { };
  finallyEnable = cfg.enable or false;
in
{
  imports = [
    inputs.nur-moraxyc.nixosModules.alist
  ];
  config = lib.mkIf finallyEnable {
    services.alist = {
      enable = true;
      package = pkgs.openlist;
    };
  };
}
