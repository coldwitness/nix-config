{
  ...
}:
let
  kernel = rec {
    name = "latest";
    version = "7.0.3";
    modDirVersion = "${version}";
    url = "https://cdn.kernel.org/pub/linux/kernel/v7.x/linux-${modDirVersion}.tar.xz";
    sha256 = "sha256-C+2tv1eIaT3eu8yRPIk/Gpc0mved3ecUTCqAtAGVnxw=";
  };
in
kernel
