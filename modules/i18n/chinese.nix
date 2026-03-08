{
  config,
  lib,
  pkgs,
  ...
}:
{
  # 时区配置
  time.timeZone = "Asia/Shanghai";
  # 语言配置
  i18n = {
    # 系统中文环境配置
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
    # 输入法配置(Fcitx5)
    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        addons = with pkgs; [
          fcitx5-mellow-themes
          qt6Packages.fcitx5-chinese-addons
        ];
        waylandFrontend = true;
      };
    };
  };
  # 字体配置
  fonts = {
    # 开启默认字体集(禁用)
    enableDefaultPackages = false;
    # 安装字体
    packages = with pkgs; [
      # Nerd 字体
      nerd-fonts.fira-code
      # 思源黑体(无衬线)
      noto-fonts-cjk-sans
      # 思源宋体(衬线)
      noto-fonts-cjk-serif
      # 彩色表情符号字体
      noto-fonts-color-emoji
    ];
    # 配置字体
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [
          "FiraCode Nerd Font"
        ];
        sansSerif = [
          "Noto Sans CJK SC"
        ];
        serif = [
          "Noto Serif CJK SC"
        ];
        emoji = [
          "Noto Color Emoji"
        ];
      };
    };
  };
}
