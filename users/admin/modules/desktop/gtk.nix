{
  lib,
  pkgs,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.desktop or { };
  finallyEnable = (cfg.type or "") != "";
in
{
  config = lib.mkIf finallyEnable {
    gtk = {
      enable = true;
      iconTheme = {
        name = "Papirus";
        package = pkgs.papirus-icon-theme;
      };
    };
  };
}
