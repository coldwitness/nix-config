{
  lib,
  pkgs,
  inputs,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.cli.mcp-nixos or { };
  finallyEnable = cfg.enable or false;
  mcp-nixos = inputs.mcp-nixos.packages.${pkgs.stdenv.hostPlatform.system}.default;
in
{
  config = lib.mkIf finallyEnable {
    environment.systemPackages = with pkgs; [
      mcp-nixos
    ];
  };
}
