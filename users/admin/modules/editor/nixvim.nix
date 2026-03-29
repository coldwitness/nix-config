  {
  lib,
  pkgs,
  inputs,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.editor.nixvim or { };
  finallyEnable = cfg.enable or false;
in
{
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];
  config = lib.mkIf finallyEnable {
    programs.nixvim = {
      enable = true;
      # Tree-sitter 语法高亮
      plugins.treesitter = {
        enable = true;
        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          nix
        ];
      };
      # Nix 语言服务器 nil
      plugins.lsp = {
        enable = true;
        servers.nil_ls = {
          enable = true;
          # 告诉 nil 用 alejandra 格式化代码
          settings.formatting.command = [ "alejandra" ];
        };
      };
      # alejandra 格式化工具可用
      extraPackages = with pkgs; [ alejandra ];
    };
  };
}
