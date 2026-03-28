{
  lib,
  pkgs,
  inputs,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.cli.mcp-nixos;
  finallyEnable = cfg.enable;
in
{
  config = lib.mkIf finallyEnable {
    environment.systemPackages = with pkgs; [
      inputs.mcp-nixos.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
