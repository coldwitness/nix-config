{
  inputs,
  ...
}:
let
  functions = import ../../functions { inherit inputs; };
in
functions.importDirFiles ./.
