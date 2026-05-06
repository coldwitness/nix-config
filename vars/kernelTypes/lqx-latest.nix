{
  ...
}:
let
  kernel = rec {
    name = "lqx";
    version = "6.19.14";
    modDirVersion = "${version}-${name}2";
    url = "https://github.com/zen-kernel/zen-kernel/archive/refs/tags/v${modDirVersion}.tar.gz";
    sha256 = "sha256-Yo6rCPdsGpZa5Kg4XEZCPn9aYTtYc29vruwO05PEhZ0=";
  };
in
kernel
