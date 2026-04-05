{
  lib,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.cli.yazi or { };
  finallyEnable = cfg.enable or false;
in
{
  config = lib.mkIf finallyEnable {
    programs.yazi = {
      enable = true;
    };
  };
}
