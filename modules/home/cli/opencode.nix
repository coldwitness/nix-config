{
  lib,
  pkgs,
  opts,
  inputs,
  ...
}:
let
  cfg = opts.cli.opencode or { };
  finallyEnable = cfg.enable or false;
  opencode-flake = inputs.opencode-flake.packages.${pkgs.stdenv.hostPlatform.system};
  opencode = opencode-flake.opencode;
  opencode-avx = opencode-flake.opencode-avx;
  package = if cfg.avx or true then opencode-avx else opencode;
in
{
  config = lib.mkIf finallyEnable {
    programs.opencode = {
      enable = true;
      inherit package;
    };
  };
}
