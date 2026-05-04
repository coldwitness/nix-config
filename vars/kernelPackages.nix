{
  inputs,
  ...
}:
let
  functions = import ../functions { inherit inputs; };
  kernelPackages = {
    latest =
      pkgs:
      functions.mkKernelPackage pkgs "7.0.3" "7.0.3"
        "https://cdn.kernel.org/pub/linux/kernel/v7.x/linux-7.0.3.tar.xz"
        "sha256-C+2tv1eIaT3eu8yRPIk/Gpc0mved3ecUTCqAtAGVnxw=";
    zen_latest =
      pkgs:
      functions.mkKernelPackage pkgs "7.0.3" "7.0.3-zen1"
        "https://github.com/zen-kernel/zen-kernel/archive/refs/tags/v7.0.3-zen1.tar.gz"
        "sha256-vUae6+v6LrMhojciVF7fsVe1G/Crd0XvKGfr1b77rY0=";
  };
in
kernelPackages
