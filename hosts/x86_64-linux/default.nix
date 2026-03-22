{
  # 系统架构
  system = "x86_64-linux";
  # 本地化
  locale = "zh-CN";
  # 工具模块
  tool = {
    onlyoffice = {
      enable = false;
    };
  };
  # 编辑器模块
  editor = {
    nixvim = {
      enable = false;
    };
    vscode = {
      enable = true;
    };
  };
  # 容器模块
  container = {
    enable = false;
    portainer-agent = {
      enable = false;
    };
  };
}
