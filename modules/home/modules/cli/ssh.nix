{
  lib,
  opts,
  inputs,
  ...
}:
let
  cfg = opts.cli.ssh or { };
  enableSopsNix = opts.service.spos-nix.enable or false;
  finallyEnable = cfg.enable or false && enableSopsNix;
in
{
  config = lib.mkIf finallyEnable {
    programs.ssh = {
      enable = true;
      # 默认配置
      enableDefaultConfig = false;
    };
  };
}
