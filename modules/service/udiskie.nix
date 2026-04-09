{
  lib,
  pkgs,
  opts,
  ...
}:
let
  cfg = opts.service.udiskie or { };
  finallyEnable = cfg.enable or false;
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
