{
  lib,
  pkgs,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.internet.qq or { };
  finallyEnable = cfg.enable or false && ((hostOptions.desktop.type or "") != "");
in
{
  config = lib.mkIf finallyEnable {
    home.packages = with pkgs; [
      qq
    ];
  };
}
