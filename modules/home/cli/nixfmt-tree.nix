{
  lib,
  pkgs,
  opts,
  ...
}:
let
  cfg = opts.cli.nixfmt-tree or { };
  finallyEnable = cfg.enable or false;
in
{
  config = lib.mkIf finallyEnable {
    home.packages = with pkgs; [
      nixfmt-tree
    ];
  };
}
