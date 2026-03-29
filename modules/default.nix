{
  lib,
  ...
}:
let
  inherit (import ../functions { inherit lib; }) importSubdirModules;
in
{
  imports = importSubdirModules ./.;
}
