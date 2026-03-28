{
  lib,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.cli.fzf;
  finallyEnable = cfg.enable;
in
{
  config = lib.mkIf finallyEnable {
    programs.fzf = {
      enable = true;
    };
  };
}
