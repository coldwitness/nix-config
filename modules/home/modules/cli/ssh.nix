{
  lib,
  inputs,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.cli.ssh or { };
  finallyEnable = cfg.enable or false;
  settingsFile = "${inputs.secrets}/ssh";
  settings = if builtins.pathExists settingsFile 
             then import settingsFile { inherit hostOptions; }
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
