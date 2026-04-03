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
      specialArgs = {
        inherit inputs pkgSets hostOptions;
      };
      modules = [
        {
          nixpkgs.pkgs = pkgSets.pkgs;
          # NixOS 首次安装的版本
          system.stateVersion = "25.11";
        }
        ../../../users
        ../../../modules
        ./hardware-configuration.nix
      ];
    };
  };
}
