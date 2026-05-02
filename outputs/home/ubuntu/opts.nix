{
  vars,
  optSets,
  hostName,
  ...
}:
let
  user = {
    predefinedOptSetsList = [
      optSets.baseEnv
      optSets.fishShell
    ];
    customOptSets = {
      count = 1;
      system = vars.systemTypes.x86_64-linux;
      nixConfigPath = "/home/ubuntu/workspace/mochen/nix-config";
      cli = {
        nvitop.enable = true;
      };
      i18n = {
        locale = vars.localeTypes.zh-cn;
      };
      hardware = {
        graphics.type = vars.gpuTypes.nvidia;
      };
    };
  };
in
{
  inherit user;
}
