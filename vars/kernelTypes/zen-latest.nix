{
  ...
}:
let
  kernel = rec {
    name = "zen";
    version = "7.0.3";
    modDirVersion = "${version}-${name}1";
    url = "https://github.com/zen-kernel/zen-kernel/archive/refs/tags/v${modDirVersion}.tar.gz";
    sha256 = "sha256-vUae6+v6LrMhojciVF7fsVe1G/Crd0XvKGfr1b77rY0=";
  };
in
kernel
