{
  inputs,
  ...
}:
let
  # 使用 builtins.readFile 读取 JSON 文件内容为字符串
  jsonFile = builtins.readFile "${inputs.secrets}/sing-box/config.json";
  # 使用 builtins.fromJSON 将字符串解析为 Nix 值
  settings = builtins.fromJSON jsonFile;
in
{
  services.sing-box = {
    enable = true;
    inherit settings;
  };
  # 启用 Linux 内核的 IP 转发功能
  boot.kernel.sysctl."net.ipv4.ip_forward" = true;
}
