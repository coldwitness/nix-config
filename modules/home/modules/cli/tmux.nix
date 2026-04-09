{
  lib,
  opts,
  ...
}:
let
  cfg = opts.cli.tmux or { };
  finallyEnable = cfg.enable or false;
in
{
  config = lib.mkIf finallyEnable {
    programs.tmux = {
      enable = true;
    };
  };
}
