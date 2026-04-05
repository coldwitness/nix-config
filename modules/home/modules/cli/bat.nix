{
  lib,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.cli.bat or { };
  finallyEnable = cfg.enable or false;
in
{
  config = lib.mkIf finallyEnable {
    programs.bat = {
      enable =true;
    };
  };
}
