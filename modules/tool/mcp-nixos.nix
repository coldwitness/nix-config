{
  pkgs,
  inputs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    inputs.mcp-nixos.packages.${pkgs.system}.default
  ];
}
