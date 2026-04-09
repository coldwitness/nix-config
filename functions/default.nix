{
  inputs,
  ...
}:
let
  importDirFiles = import ./importDirFiles.nix { inherit inputs; };
in
importDirFiles ./.
