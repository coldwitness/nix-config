{
  lib,
  opts,
  ...
}:
let
  cfg = opts.cli.direnv or { };
  finallyEnable = cfg.enable or false;
in
{
  config = lib.mkIf finallyEnable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
