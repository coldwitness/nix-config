{
  lib,
  ...
}:
{
  importSubdirModules = import ./importSubdirModules.nix { inherit lib; };
}
