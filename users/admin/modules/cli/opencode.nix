{
  ...
}:
{
  programs.opencode = {
    enable = true;
    settings = {
      mcp = {
        mcp-nixos = {
          enabled = true;
          type = "local";
          command = [ "mcp-nixos" ];
        };
      };
    };
  };
}
