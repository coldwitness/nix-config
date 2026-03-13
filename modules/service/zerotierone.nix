{
  inputs,
  ...
}:
let
  # 使用 builtins.readFile 读取 JSON 文件内容为字符串
  jsonFile = builtins.readFile "${inputs.secrets}/zerotierone/config.json";
  # 使用 builtins.fromJSON 将字符串解析为 Nix 值
  settings = builtins.fromJSON jsonFile;
in
{
  services.zerotierone ={
    enable = true;
    joinNetworks = settings.networks;
  };
}
