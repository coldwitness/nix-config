{
  lib,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.cli.starship;
  finallyEnable = cfg.enable;
in
{
  config = lib.mkIf finallyEnable {
    programs.starship = {
      enable = true;
      settings = {
        "$schema" = "https://starship.rs/config-schema.json";
        format = ""
          + "[ ](#FF69B4)"
          + "$os"
          + "$username"
          + "[](bg:#FF87C3 fg:#FF69B4)"
          + "$directory"
          + "[](bg:#FFA5D2 fg:#FF87C3)"
          + "$git_branch"
          + "[](bg:#FFC3E1 fg:#FFA5D2)"
          + "$git_status"
          + "[](bg:#FFE1F0 fg:#FFC3E1)"
          + "$c"
          + "$elixir"
          + "$elm"
          + "$golang"
          + "$gradle"
          + "$haskell"
          + "$java"
          + "$julia"
          + "$nodejs"
          + "$nim"
          + "$rust"
          + "$scala"
          + "[](bg:#FFFFFF fg:#FFE1F0 )"
          + "$time"
          + "[ ](fg:#FFFFFF)"
        ;
        os = {
          style = "bg:#FF69B4 fg:#FFFFFF";
          disabled = false;
          symbols = {
            NixOS = " ";
          };
        };
        username = {
          show_always = true;
          style_user = "bg:#FF69B4 fg:#FFFFFF";
          style_root = "bg:#FF69B4 fg:#FFFFFF";
          format = "[$user ]($style)";
          disabled = false;
        };
        directory = {
          style = "bg:#FF87C3 fg:#FFFFFF";
          format = "[ $path ]($style)";
          truncation_length = 3;
          truncation_symbol = "…/";
          substitutions = {
            Documents = "󰈙 ";
            Downloads = " ";
            Music = " ";
            Pictures = " ";
          };
        };
        git_branch = {
          symbol = "";
          style = "bg:#FFA5D2 fg:#FFFFFF";
          format = "[ $symbol $branch ]($style)";
        };
        git_status = {
          style = "bg:#FFC3E1 fg:#FFFFFF";
          format = "[$all_status$ahead_behind ]($style)";
        };
        c = {
          symbol = " ";
          style = "bg:#FFE1F0 fg:#FFA5D2";
          format = "[ $symbol ($version) ]($style)";
        };
        cpp = {
          symbol = " ";
          style = "bg:#FFE1F0 fg:#FFA5D2";
          format = "[ $symbol ($version) ]($style)";
        };
        elixir = {
          symbol = " ";
          style = "bg:#FFE1F0 fg:#FFA5D2";
          format = "[ $symbol ($version) ]($style)";
        };
        elm = {
          symbol = " ";
          style = "bg:#FFE1F0 fg:#FFA5D2";
          format = "[ $symbol ($version) ]($style)";
        };
        golang = {
          symbol = " ";
          style = "bg:#FFE1F0 fg:#FFA5D2";
          format = "[ $symbol ($version) ]($style)";
        };
        gradle = {
          symbol = " ";
          style = "bg:#FFE1F0 fg:#FFA5D2";
          format = "[ $symbol ($version) ]($style)";
        };
        haskell = {
          symbol = " ";
          style = "bg:#FFE1F0 fg:#FFA5D2";
          format = "[ $symbol ($version) ]($style)";
        };
        java = {
          symbol = " ";
          style = "bg:#FFE1F0 fg:#FFA5D2";
          format = "[ $symbol ($version) ]($style)";
        };
        julia = {
          symbol = " ";
          style = "bg:#FFE1F0 fg:#FFA5D2";
          format = "[ $symbol ($version) ]($style)";
        };
        nodejs = {
          symbol = "";
          style = "bg:#FFE1F0 fg:#FFA5D2";
          format = "[ $symbol ($version) ]($style)";
        };
        nim = {
          symbol = "󰆥 ";
          style = "bg:#FFE1F0 fg:#FFA5D2";
          format = "[ $symbol ($version) ]($style)";
        };
        rust = {
          symbol = "";
          style = "bg:#FFE1F0 fg:#FFA5D2";
          format = "[ $symbol ($version) ]($style)";
        };
        scala = {
          symbol = " ";
          style = "bg:#FFE1F0 fg:#FF69B4";
          format = "[ $symbol ($version) ]($style)";
        };
        time = {
          disabled = false;
          time_format = "%R";
          style = "bg:#FFFFFF fg:#FF87C3";
          format = "[  $time ]($style)";
        };
      };
    };
  };
}
