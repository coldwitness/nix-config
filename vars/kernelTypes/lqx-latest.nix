{
  ...
}:
let
  kernel = rec {
    name = "lqx";
    version = "7.0.5";
    modDirVersion = "${version}-${name}1";
    url = "https://github.com/zen-kernel/zen-kernel/archive/refs/tags/v${modDirVersion}.tar.gz";
    sha256 = "sha256-qr3O5Vh5C7Vw0Z4M6YBRNNKTRoIKp7PeAJ2/yi1sbi8=";
  };
in
kernel
