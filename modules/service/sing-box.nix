{
  lib,
  opts,
  inputs,
  ...
}:
let
  cfg = opts.service.sing-box or { };
  finallyEnable = cfg.enable or false;
  settingsFile = "${inputs.secrets}/sing-box";
  settings = if builtins.pathExists settingsFile then import settingsFile else { };
in
{
  config = lib.mkIf finallyEnable {
    services.sing-box = {
      enable = true;
      inherit settings;
    };
    # 启用 Linux 内核的 IP 转发功能
    boot.kernel.sysctl."net.ipv4.ip_forward" = true;
  };
}
