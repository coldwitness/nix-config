{
  vars,
  optSets,
  hostName,
  ...
}:
let
  user = {
    count = 1;
    system = vars.systemTypes.x86_64-linux;
    predefinedOptSetsList = [
      optSets.baseEnv
      optSets.fishShell
    ];
    customOptSets = {
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
  };
in
{
  inherit user;
}
