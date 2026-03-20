{
  pkgs,
  inputs,
  hostConfig,
  ...
}:
{
  programs.lutris = {
    enable = true;
    # 为 lutris 配合 umu-launcher 使用而添加的 proton 软件包列表
    protonPackages = [
      inputs.dw-proton.packages.${hostConfig.system}.dw-proton
    ];
  };
  home.packages = with pkgs; [
    umu-launcher
  ];
}
