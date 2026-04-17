{
  inputs,
  ...
}:
let
  importFilesForAttrs = import ./importFilesForAttrs.nix { inherit inputs; };
in
importFilesForAttrs ./.
