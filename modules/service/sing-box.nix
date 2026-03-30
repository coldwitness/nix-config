{
  lib,
  inputs,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.service.sing-box or { };
  finallyEnable = cfg.enable or false;
  settings = if builtins.pathExists "${inputs.secrets}/sing-box" 
             then import "${inputs.secrets}/sing-box" 
             else { };
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
