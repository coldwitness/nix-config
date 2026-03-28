{
  lib,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.cli.git;
  finallyEnable = cfg.enable;
in
{
  config = lib.mkIf finallyEnable {
    programs.git = {
      enable = true;
      settings = {
        user ={
          name = "骑士姬";
          email = "2067834160@qq.com";
        };
        init.defaultBranch = "master";
      };
    };
  };
}
