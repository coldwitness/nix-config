{
  pkgs,
  lib,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.cli.eza;
  finallyEnable = cfg.enable;
in
{
  config = lib.mkIf finallyEnable {
    environment.systemPackages = with pkgs; [
      eza
    ];
  };
}
