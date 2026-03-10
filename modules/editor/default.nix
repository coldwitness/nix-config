{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
      ./nixvim.nix
      ./vscode-latest.nix
    ];
}
