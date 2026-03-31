{
  lib,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.cli.fzf or { };
  finallyEnable = cfg.enable or false;
in
{
  config = lib.mkIf finallyEnable {
    programs.fzf = {
      enable = true;
    };
  };
}
