{
  lib,
  inputs,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.cli.ssh;
  finallyEnable = cfg.enable;
  settings = import "${inputs.secrets}/ssh";
in
{
  config = lib.mkIf finallyEnable {
    programs.ssh = {
      enable = true;
      # 默认配置
      enableDefaultConfig = false;
      matchBlocks = settings.matchBlocks;
    };
  };
}
