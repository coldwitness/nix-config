{
  inputs,
  ...
}:
let
  inherit (import ../functions { inherit inputs; }) importDirFiles;
in
importDirFiles ./.
