{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
      ./nvim.nix
      ./vscode.nix
    ];
}
