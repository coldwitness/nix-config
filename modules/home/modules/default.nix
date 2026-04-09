{
  inputs,
  ...
}:
let
  inherit (import ../../../functions { inherit inputs; }) importSubdirModules;
in
{
  imports = importSubdirModules ./.;
}
