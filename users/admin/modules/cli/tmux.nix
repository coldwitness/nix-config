{
  lib,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.cli.tmux or { };
  finallyEnable = cfg.enable or false;
in
{
  config = lib.mkIf finallyEnable {
    programs.tmux = {
      enable = true;
    };
  };
}
