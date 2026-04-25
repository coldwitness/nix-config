{
  lib,
  pkgs,
  opts,
  inputs,
  ...
}:
let
  cfg = opts.cli.mcp-nixos or { };
  finallyEnable = cfg.enable or false;
  # mcp-nixos = inputs.mcp-nixos.packages.${pkgs.stdenv.hostPlatform.system}.default;
in
{
  config = lib.mkIf finallyEnable {
    home.packages = with pkgs; [
      mcp-nixos
    ];
  };
}
