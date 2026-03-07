{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
      ./nixvim.nix
      ./vscode/vscode-latest.nix
    ];
}
