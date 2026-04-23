{
  lib,
  opts,
  ...
}:
let
  cfg = opts.cli.nix-ld or { };
  finallyEnable = cfg.enable or false;
in
{
  config = lib.mkIf finallyEnable {
    programs.nix-ld.enable = true;
  };
}
