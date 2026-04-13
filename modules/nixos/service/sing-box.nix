{
  lib,
  opts,
  inputs,
  ...
}:
let
  cfg = opts.service.sing-box or { };
  finallyEnable = cfg.enable or false;
in
{
  config = lib.mkIf finallyEnable {
    services.sing-box = {
      enable = true;
    };
    # 启用 Linux 内核的 IP 转发功能
    boot.kernel.sysctl."net.ipv4.ip_forward" = true;
  };
}
