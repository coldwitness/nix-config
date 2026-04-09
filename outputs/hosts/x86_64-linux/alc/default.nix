{
  lib,
  inputs,
  system,
  pkgSets,
  ...
}:
let
  inherit system;
  opts = import ./opts.nix { inherit inputs; };
in
{
  nixosConfigurations = {
    alc = lib.nixosSystem {
      inherit system;
      pkgs = pkgSets.pkgs;
      specialArgs = {
        inherit inputs opts pkgSets;
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
