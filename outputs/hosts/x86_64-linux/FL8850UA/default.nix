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
    FL8850UA = lib.nixosSystem {
      inherit system;
      pkgs = pkgSets.pkgs;
      specialArgs = {
        inherit inputs pkgSets hostOptions;
      };
      modules = [
        ../../users
        ../../../../modules
        ./hardware-configuration.nix
        { system.stateVersion = "25.11"; }
      ];
    };
  };
}
