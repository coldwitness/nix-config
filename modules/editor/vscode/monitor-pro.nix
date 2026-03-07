{
  stdenv,
  lib,
  vscode-utils,
  fetchurl,
  version,
  hash,
}:
let
  # 下载 gzip 压缩的原始文件
  gzippedVsix = fetchurl {
    url = "https://marketplace.visualstudio.com/_apis/public/gallery/publishers/nexmoe/vsextensions/monitor-pro/${version}/vspackage";
    inherit hash;
    name = "monitor-pro.vsix.gz";
  };
  # 解压得到真正的 .vsix 文件(应为 ZIP 格式)
  vsix = stdenv.mkDerivation {
    name = "nexmoe.monitor-pro-0.6.1.vsix";
    src = gzippedVsix;
    # 不自动解包
    dontUnpack = true;
    # 执行解压
    buildPhase = ''
      gunzip < $src > $out
    '';
    # 无需安装, $out 已是最终文件
    installPhase = "true";
  };
in
vscode-utils.buildVscodeExtension {
  # 显式提供 pname
  pname = "nexmoe.monitor-pro";
  # 显式提供 version
  version = "0.6.1";
  # 显式提供发布者
  vscodeExtPublisher = "nexmoe";
  # 显式提供扩展名
  vscodeExtName = "monitor-pro";
  # 显式添加唯一标识符
  vscodeExtUniqueId = "nexmoe.monitor-pro";
  # 使用解压后的 .vsix 文件
  src = vsix;
  # 元信息
  meta = with lib; {
    description = "Provides a unified python environment experience";
    downloadPage = "https://marketplace.visualstudio.com/items?itemName=nexmoe.monitor-pro";
    homepage = "https://github.com/nexmoe/vscode-monitor-pro";
  };
}
