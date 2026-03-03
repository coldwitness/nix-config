{
  config,
  lib,
  pkgs,
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
      # 浏览器偏好设置
      preferences = {
        # 强制使用操作系统语言
        "intl.locale.requested" = firefoxLocale; 
      };
      # 浏览器策略配置
      policies = {
        # 始终显示书签工具栏
        DisplayBookmarksToolbar = true;
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
        # 添加自定义搜索引擎
        SearchEngines = {
          # 默认搜索引擎
          Default = "Bing";
          Add = [
            {
              Name = "Nix Packages";
              URLTemplate = "https://search.nixos.org/packages?type=packages&query={searchTerms}";
            }
          ];
          # 隐藏不需要的引擎
          Remove = [
            "DuckDuckGo"
            "Google"
            "Perplexity"
            "Wikipedia (en)"
          ];
        };
      };
    };                   
  };
}
