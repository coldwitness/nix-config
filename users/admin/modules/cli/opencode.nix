{
  lib,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.cli.opencode;
  finallyEnable = cfg.enable;
in
{
  config = lib.mkIf finallyEnable {
    programs.opencode = {
      enable = true;
      settings = {
        mcp = {
          mcp-nixos = {
            enabled = true;
            type = "local";
            command = [ "mcp-nixos" ];
          };
        };
      };
    };
  };
}
