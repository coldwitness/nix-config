{
  ...
}:
let
  kernel = rec {
    name = "latest";
    version = "7.0.6";
    modDirVersion = "${version}";
    url = "https://cdn.kernel.org/pub/linux/kernel/v7.x/linux-${modDirVersion}.tar.xz";
    sha256 = "sha256-y6REQKpXr/18ISQdxbwjSw31PEmfj/w+vCkN0zkKdSM=";
  };
in
kernel
