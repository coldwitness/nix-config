{
  lib,
  opts,
  inputs,
  ...
}:
let
  cfg = opts.cli.ssh or { };
  finallyEnable = cfg.enable or false;
  settingsFile = "${inputs.secrets}/ssh";
  settings =
    if builtins.pathExists settingsFile 
    then import settingsFile { inherit opts; }
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
