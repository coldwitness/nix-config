{
  lib,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.cli.tmux;
  finallyEnable = cfg.enable;
in
{
  config = lib.mkIf finallyEnable {
    programs.tmux = {
      enable = true;
    };
  };
}
