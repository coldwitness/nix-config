{
  inputs,
  ...
}:
dir:
let
  inherit (inputs.nixpkgs) lib;
  content = builtins.readDir dir;
  nixFiles = builtins.attrNames (lib.filterAttrs (
    name: type: type == "regular"
    && lib.hasSuffix ".nix" name
    && name != "default.nix"
  ) content);
  fileNames = builtins.map (file: lib.removeSuffix ".nix" file) nixFiles;
in
builtins.listToAttrs (lib.imap0 (i: name: {
  inherit name;
  value = import (dir + "/${builtins.elemAt nixFiles i}") { inherit inputs; };
}) fileNames)
