{
  ...
}:
{
  boot = {
    # 引导加载器配置
    loader = {
      # 启用 systemd-boot 引导程序
      systemd-boot.enable = true;
      # 允许修改 EFI 变量, 支持 UEFI 引导
      efi.canTouchEfiVariables = true;
    };
  };
}
