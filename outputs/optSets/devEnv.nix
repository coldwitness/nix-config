{
  ...
}:
{
  # 提供开发此仓库所需要的环境
  cli = {
    # NixOS MCP
    mcp-nixos.enable = true;
    # nix 文件批量格式化工具
    nixfmt-tree.enable = true;
  };
}
