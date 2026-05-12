{
  ...
}:
let
  kernel = rec {
    name = "zen";
    version = "7.0.6";
    modDirVersion = "${version}-${name}1";
    url = "https://github.com/zen-kernel/zen-kernel/archive/refs/tags/v${modDirVersion}.tar.gz";
    sha256 = "sha256-1hnkUS8MsaU2hbxH6jfOuYKalS3Tg2NJqg3wiSwtcUQ=";
  };
in
kernel
