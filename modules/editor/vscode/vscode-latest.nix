{
  config,
  lib,
  pkgs,
  ...
}:
let
  # 包装最新版 vscode
  version = "1.110.1";
  platform = "linux-x64";
  url = "https://update.code.visualstudio.com/${version}/${platform}/stable";
  hash = "sha256-nXxPuopZX8gOWrco++VYl0AAsCxDUykkoSgWOiHFUYw=";
  vscode-latest = pkgs.vscode.overrideAttrs (oldAttrs: {
    inherit version;
    src = pkgs.fetchurl {
      inherit url;
      inherit hash;
      name = "VSCode_${version}_${platform}.tar.gz";
    };
  });
in
{
  programs.vscode = {
    enable = true;
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
      adpyke.codesnap
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "monitor-pro";
        publisher = "nexmoe";
        version = "0.6.1";
        sha256 = "sha256-UB46ElSLqsxe3idNjFc3VDeYxzwD+Fz9AA9qUV/b2ys=";
      }
      {
        name = "vscode-python-envs";
        publisher = "ms-python";
        version = "1.21.10651016";
        sha256 = "sha256-yaQrZKdncWWjEuBp3SLNZ3kBIq7y2FiEr9xCQmgugso=";
      }
    ];
  };
}
