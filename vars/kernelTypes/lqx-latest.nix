{
  ...
}:
let
  kernel = rec {
    name = "lqx";
    version = "7.0.6";
    modDirVersion = "${version}-${name}1";
    url = "https://github.com/zen-kernel/zen-kernel/archive/refs/tags/v${modDirVersion}.tar.gz";
    sha256 = "sha256-ErTKBIlICKr83X2ULiKltMibu++lWfLMCuRN4dBZNy8=";
  };
in
kernel
