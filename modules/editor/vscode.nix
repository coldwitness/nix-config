{
  config,
  lib,
  pkgs,
  ...
}:
{
  networking.proxy.default = "http://192.168.1.52:7890/";
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      # nexmoe.monitor-pro
      ms-ceintl.vscode-language-pack-zh-hans
      pkief.material-icon-theme
      mhutchie.git-graph
    ];
  };
}
