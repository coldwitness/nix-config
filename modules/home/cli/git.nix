{
  lib,
  opts,
  ...
}:
let
  cfg = opts.cli.git or { };
  finallyEnable = cfg.enable or false;
  user = cfg.user or { };
  nvimEnable = opts.editor.nixvim.enable or false;
in
{
  config = lib.mkIf finallyEnable {
    programs.git = {
      enable = true;
      settings = {
        inherit user;
        init.defaultBranch = "master";
        core.editor = if nvimEnable then "nvim" else "nano";
      };
    };
  };
}
