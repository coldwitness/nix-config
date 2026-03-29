{
  lib,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.cli.eza or { };
  finallyEnable = cfg.enable or false;
in
{
  config = lib.mkIf finallyEnable {
    programs.eza = {
      enable = true;
    };
  };
}
