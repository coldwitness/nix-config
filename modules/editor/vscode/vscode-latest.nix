{
  config,
  lib,
  pkgs,
  ...
}:
let
  # 包装最新版 vscode
  newVersion = "1.110.1";
  platform = "linux-x64";
  downloadUrl = "https://update.code.visualstudio.com/${newVersion}/${platform}/stable";
  fakeHash = "sha256-nXxPuopZX8gOWrco++VYl0AAsCxDUykkoSgWOiHFUYw=";
  vscode-latest = pkgs.vscode.overrideAttrs (oldAttrs: {
    version = newVersion;
    src = pkgs.fetchurl {
      url = downloadUrl;
      hash = fakeHash;
      name = "VSCode_${newVersion}_${platform}.tar.gz";
    };
  });
  # 包装插件
  knightfemale = {
    vscode-python-envs = pkgs.callPackage ./vscode-python-envs.nix {
      version = "1.21.10651016";
      # 如需自动更新脚本, 可传入
      # vscode-extension-update-script = pkgs.vscode-extension-update-script;
    };
    monitor-pro = pkgs.callPackage ./monitor-pro.nix {
        version = "0.6.1";
        hash = "sha256-aqlsNt5fiR2LKlIkZj+jUcJhQHLCk7G+WW+Z/FtgzIw=";
    };
  };
in
{
  programs.vscode = {
    enable = true;
    # 用覆盖后的包
    package = vscode-latest;
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
      esbenp.prettier-vscode
      ms-python.python
      ms-python.debugpy
      ms-python.vscode-pylance
      ms-python.black-formatter
      knightfemale.vscode-python-envs
      knightfemale.monitor-pro
      adpyke.codesnap
    ];
  };
}
