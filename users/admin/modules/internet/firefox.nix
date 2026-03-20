{
  pkgs,
  hostConfig,
  pkgs-unstable,
  ...
}:
{
  programs = {
    firefox = {
      # 启用 Firefox 浏览器
      enable = true;
      package = pkgs-unstable.firefox;
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
      };
      # 浏览器偏好设置
      profiles = {
        default = {
          id = 0;
          settings = {
            # 强制使用操作系统语言
            "intl.locale.requested" = hostConfig.locale;
            # 1: 手动配置代理
            # 2: 自动代理配置的 URL
            # 3: 不使用代理服务器
            # 4: 自动检测此网络的代理设置
            # 5: 使用系统代理设置
            "network.proxy.type" = 4;
          };
          # 搜索引擎配置
          search = {
            # 默认搜索引擎
            default = "bing";
            force = true;
            # 添加自定义搜索引擎
            engines = {
              "Nix Packages" = {
                urls = [ { template = "https://search.nixos.org/packages?channel=unstable&query={searchTerms}"; } ];
                icon = "$https://search.nixos.org/favicon.png";
                definedAliases = [ "@np" ];
              };
              "Nix Options" = {
                urls = [ { template = "https://search.nixos.org/options?channel=unstable&query={searchTerms}"; } ];
                icon = "https://search.nixos.org/favicon.png";
                definedAliases = [ "@no" ];
              };
              # 隐藏不需要的引擎
              "ddg".metaData.hidden = true;
              "baidu".metaData.hidden = true;
              "google".metaData.hidden = true;
              "perplexity".metaData.hidden = true;
              "wikipedia-zh-CN".metaData.hidden = true;
            };
          };
          # 安装扩展
          extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
            # 详情: https://nur.nix-community.org/repos/rycee/
            # 简约翻译
            kiss-translator
          ];
        };
      };
    };                   
  };
}
