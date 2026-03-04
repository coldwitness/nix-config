{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
      ./nixvim.nix
      ./vscode.nix
    ];
}
