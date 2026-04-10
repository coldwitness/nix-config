{
  inputs,
  ...
}:
let
  functions = import ../functions { inherit inputs; };
in
{
  imports = functions.importSubdirModules ./.;
}
