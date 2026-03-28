{
  lib,
  pkgs,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.internet.qq;
  finallyEnable = cfg.enable && (hostOptions.desktop.type != "");
in
{
  config = lib.mkIf finallyEnable {
    home.packages = with pkgs; [
      qq
    ];
  };
}
