{
  lib,
  opts,
  ...
}:
let
  cfg = opts.hardware.boot-loader or { };
  finallyEnable = (cfg.type or "systemd-boot") == "systemd-boot";
  efiSysMountPoint = cfg.efiSysMountPoint or "/boot";
in
{
  config = lib.mkIf finallyEnable {
    boot.loader = {
      # EFI系统分区挂载点
      efi.efiSysMountPoint = efiSysMountPoint;
      # 允许修改 EFI 变量, 支持 UEFI 引导
      efi.canTouchEfiVariables = true;
      # 启用 systemd-boot 引导程序
      systemd-boot.enable = true;
    };
  };
}
