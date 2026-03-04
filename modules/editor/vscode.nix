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
      ms-ceintl.vscode-language-pack-zh-hans
      pkief.material-icon-theme
      mhutchie.git-graph
      jnoortheen.nix-ide
      w88975.code-translate
      usernamehw.errorlens
      oderwat.indent-rainbow
      christian-kohler.path-intellisense
      tamasfe.even-better-toml
      shd101wyy.markdown-preview-enhanced
    ];
  };
}
