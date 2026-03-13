{
  lib,
  config,
  pkgs-unstable,
  ...
}:
let
  # 从系统配置获取默认 locale
  systemLocale = config.i18n.defaultLocale or "en_US.UTF-8";

  # 转换为 BCP47 格式: 去掉后缀, 下划线变连字符
  firefoxLocale =
    let
      # 去掉点号及之后的部分
      base = lib.head (lib.splitString "." systemLocale);
    in
      # 将下划线替换为连字符
      lib.replaceStrings ["_"] ["-"] base;
in
{
  programs = {
    firefox = {
      # 启用 Firefox 浏览器
      enable = true;
      package = pkgs-unstable.firefox;
      # 浏览器偏好设置
      preferences = {
        # 强制使用操作系统语言
        "intl.locale.requested" = firefoxLocale; 
        # 1: 手动配置代理
        # 2: 自动代理配置的 URL
        # 3: 不使用代理服务器
        # 4: 自动检测此网络的代理设置
        # 0: 使用系统代理设置
        "network.proxy.type" = 4;
      };
      # 浏览器策略配置
      policies = {
        # 启动时不检查是否为默认浏览器
        DontCheckDefaultBrowser = true;
        # 始终显示书签工具栏
        DisplayBookmarksToolbar = true;
        # 不创建自带的默认书签
        NoDefaultBookmarks = true;
        # 受控书签
        ManagedBookmarks = [
           {
             name = "AI 工具";
             children = [
               {
                 name = "DeepSeek";
                 url = "https://chat.deepseek.com/";
               }
               {
                 name = "Kimi";
                 url = "https://www.kimi.com/";
               }
             ];
           }
         ];
        SearchEngines = {
          # 默认搜索引擎
          Default = "Bing";
          # 添加自定义搜索引擎
          Add = [
            {
              Name = "Nix Packages";
              URLTemplate = "https://search.nixos.org/packages?type=packages&query={searchTerms}";
            }
          ];
          # 隐藏不需要的引擎
          Remove = [
            "百度"
            "维基百科"
            "Google"
            "Perplexity"
            "DuckDuckGo"
            "Wikipedia (en)"
          ];
        };
        # 安装扩展
        ExtensionSettings = {
          # 阻止除指定的插件之外的所有扩展(包括语言)
          # "*".installation_mode = "blocked";
          # 沉浸式翻译
          "{5efceaa7-f3a2-4e59-a54b-85319448e305}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/immersive-translate/latest.xpi";
            installation_mode = "force_installed";
          };
        };
      };
    };                   
  };
}
