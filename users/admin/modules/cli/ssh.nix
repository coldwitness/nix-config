{
  lib,
  inputs,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.cli.ssh or { };
  finallyEnable = cfg.enable or false;
  settings = if builtins.pathExists "${inputs.secrets}/ssh" 
             then import "${inputs.secrets}/ssh" 
             else { };
  matchBlocks = settings.matchBlocks or { };
in
{
  config = lib.mkIf finallyEnable {
    programs.ssh = {
      enable = true;
      # 默认配置
      enableDefaultConfig = false;
      inherit matchBlocks;
    };
  };
}
