{
  ...
}:
let
  kernel = rec {
    name = "zen";
    version = "7.0.5";
    modDirVersion = "${version}-${name}1";
    url = "https://github.com/zen-kernel/zen-kernel/archive/refs/tags/v${modDirVersion}.tar.gz";
    sha256 = "sha256-zqXaBwQnMHSUExLODhkcl5/gbAG3qjBNny1QPJrHNWM=";
  };
in
kernel
