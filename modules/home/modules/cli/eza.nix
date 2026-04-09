{
  lib,
  opts,
  ...
}:
let
  cfg = opts.cli.eza or { };
  finallyEnable = cfg.enable or false;
in
{
  config = lib.mkIf finallyEnable {
    programs.eza = {
      enable = true;
    };
  };
}
