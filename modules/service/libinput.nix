{
  lib,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.service.libinput or { };
  finallyEnable = cfg.enable or false;
in
{
  config = lib.mkIf finallyEnable {
    services = {
      # 启用输入设备支持(在大多数桌面管理器中默认启用)
      libinput.enable = true;
    };
  };
}
