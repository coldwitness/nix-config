{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      # nexmoe.monitor-pro
      ms-ceintl.vscode-language-pack-zh-hans
      pkief.material-icon-theme
      mhutchie.git-graph
      jnoortheen.nix-ide
    ];
  };
}
