{
  ...
}:
let
  kernel = rec {
    name = "latest";
    version = "7.0.5";
    modDirVersion = "${version}";
    url = "https://cdn.kernel.org/pub/linux/kernel/v7.x/linux-${modDirVersion}.tar.xz";
    sha256 = "sha256-ll+wocFnU5n8YMYGOyJ8BSMEG1+aZitmRi8SEsQ4rDw=";
  };
in
kernel
