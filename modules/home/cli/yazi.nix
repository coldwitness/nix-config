{
  lib,
  opts,
  ...
}:
let
  cfg = opts.cli.yazi or { };
  finallyEnable = cfg.enable or false;
in
{
  config = lib.mkIf finallyEnable {
    programs.yazi = {
      enable = true;
    };
  };
}
