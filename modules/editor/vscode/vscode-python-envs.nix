{
  stdenv,
  lib,
  vscode-utils,
  vscode-extension-update-script,
  version,
}:
let
  supported = {
    x86_64-linux = {
      hash = "sha256-0dE88AxtJ5xN1jgbHLSb0nnHsutH6VVerSv6T4PhYO4=";
      arch = "linux-x64";
    };
  };
  # 选择当前系统的配置, 若不支持则报错
  base = supported.${stdenv.hostPlatform.system}
    or (throw "Unsupported system: ${stdenv.hostPlatform.system}");
in
vscode-utils.buildVscodeMarketplaceExtension {
  # 市场引用
  mktplcRef = base // {
    name = "vscode-python-envs";
    publisher = "ms-python";
    inherit version;
  };
  passthru.updateScript = vscode-extension-update-script { };
  # 元信息
  meta = with lib; {
    description = "Provides a unified python environment experience";
    downloadPage = "https://marketplace.visualstudio.com/items?itemName=ms-python.vscode-python-envs";
    homepage = "https://github.com/microsoft/vscode-python-environments";
    changelog = "https://github.com/microsoft/vscode-python-environments/releases";
    license = licenses.unfree;
    platforms = builtins.attrNames supported;
  };
}
