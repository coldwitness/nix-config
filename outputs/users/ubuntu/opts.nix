{
  inputs,
  ...
}:
let
  vars = import ../../../vars { inherit inputs; };
  optSets = import ../../optSets { inherit inputs; };
  functions = import ../../../functions { inherit inputs; };
  predefinedOptSetsList = [
    optSets.baseEnv
    optSets.fishShell
  ];
  customOptSets ={
    nixConfigPath = "/home/ubuntu/workspace/mochen/nix-config";
    cli = {
      nvitop.enable = true;
    };
    i18n = {
      locale = vars.localeTypes.zh-cn;
    };
    hardware = {
      graphics = {
        type = vars.gpuTypes.nvidia;
      };
    };
  };
  opts = functions.mergeOptSetsList customOptSets predefinedOptSetsList;
in
opts
