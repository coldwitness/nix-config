{
  inputs,
  ...
}:
let
  settings = import "${inputs.secrets}/ssh";
in
{
  programs.ssh = {
    enable = true;
    # 默认配置
    enableDefaultConfig = false;
    matchBlocks = settings.matchBlocks;
  };
}
