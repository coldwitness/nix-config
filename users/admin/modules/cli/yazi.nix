{
  lib,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.cli.yazi;
  finallyEnable = cfg.enable;
in
{
  config = lib.mkIf finallyEnable {
    programs.yazi = {
      enable = true;
    };
  };
}
