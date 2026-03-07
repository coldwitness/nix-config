{
  config,
  lib,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    # AMD GPU 监控工具
    nvtopPackages.amd
  ];
}
