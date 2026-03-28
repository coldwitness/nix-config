{
  pkgs,
  lib,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.service.udiskie;
  finallyEnable = cfg.enable;
in
{
  config = lib.mkIf finallyEnable {
    # 自动挂载 U 盘
    environment.systemPackages = with pkgs; [
      udiskie
    ];
    services.udisks2.enable = true;
  };
}
