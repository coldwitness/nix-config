{
  lib,
  inputs,
  system,
  pkgSets,
  ...
}:
let
  count = 1;
  baseHostName = lib.baseNameOf (toString ./.);
  hostNames =
    if count <= 1
    then [ baseHostName ]
    else builtins.genList (i: "${baseHostName}-${builtins.toString (i + 1)}") count;
  buildHost = hostName:
    let
      opts = import ./opts.nix { inherit inputs hostName; };
    in
    {
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
in
{
  nixosConfigurations = builtins.listToAttrs (
    builtins.map (hn: { name = hn; value = (buildHost hn).${hn}; }) hostNames
  );
}
