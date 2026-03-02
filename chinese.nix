{ config, lib, pkgs, ... }:

{
  # 系统中文环境配置
  i18n = {
    defaultLocale = "zh_CN.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "zh_CN.UTF-8";
      LC_IDENTIFICATION = "zh_CN.UTF-8";
      LC_MEASUREMENT = "zh_CN.UTF-8";
      LC_MONETARY = "zh_CN.UTF-8";
      LC_NAME = "zh_CN.UTF-8";
      LC_NUMERIC = "zh_CN.UTF-8";
      LC_PAPER = "zh_CN.UTF-8";
      LC_TELEPHONE = "zh_CN.UTF-8";
      LC_TIME = "zh_CN.UTF-8";
    };
    supportedLocales = [
     "zh_CN.UTF-8/UTF-8"
     "en_US.UTF-8/UTF-8"
    ];
  };

  # 输入法配置(Fcitx5)
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      addons = with pkgs; [
        qt6Packages.fcitx5-chinese-addons
      ];
      waylandFrontend = true;
    };
  };

  # 字体配置
  fonts = {
    packages = with pkgs; [
      fira-code
      fira-code-symbols
      noto-fonts
      # 思源黑体(无衬线)
      noto-fonts-cjk-sans
      # 思源宋体(衬线)
      noto-fonts-cjk-serif
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [
          "Fira Code"
          "Noto Mono"
        ];
        sansSerif = [
          "Noto Sans CJK SC"
        ];
        serif = [
          "Noto Serif CJK SC"
        ];
      };
    };
    enableDefaultPackages = true;
  };
}
