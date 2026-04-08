{
  lib,
  inputs,
  system,
  pkgSets,
  ...
}:
let
  inherit system;
  hostOptions = import ./hostOptions.nix { inherit inputs; };
in
{
  nixosConfigurations = {
    x86_64-linux = lib.nixosSystem {
      inherit system;
      pkgs = pkgSets.pkgs;
      specialArgs = {
        inherit inputs pkgSets hostOptions;
      };
      modules = [
        ../../../users
        ../../../../modules
        ./hardware-configuration.nix
        { system.stateVersion = "25.11"; }
      ];
    };
  };
}
