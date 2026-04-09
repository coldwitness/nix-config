{
  lib,
  inputs,
  system,
  pkgSets,
  ...
}:
let
  hostName = lib.baseNameOf (toString ./.);
  opts = import ./opts.nix { inherit inputs hostName; };
in
{
  nixosConfigurations = {
    ${hostName} = lib.nixosSystem {
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
