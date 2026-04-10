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
  ];
  customOptSets ={
    nixConfigPath = "/home/mint/workspace/mochen/nix-config";
    cli = {
      bat.enable = true;
      eza.enable = true;
      fzf.enable = true;
      ssh.enable = true;
      tmux.enable = true;
      yazi.enable = true;
      btop.enable = true;
      nvitop.enable = true;
      starship.enable = true;
      fastfetch.enable = true;
    };
    i18n = {
      locale = vars.localeTypes.zh-cn;
    };
    shell = {
      fish.enable = true;
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
