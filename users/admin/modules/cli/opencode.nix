{
  lib,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.cli.opencode or { };
  finallyEnable = cfg.enable or false;
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
