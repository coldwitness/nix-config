{
  lib,
  opts,
  ...
}:
let
  cfg = opts.cli.starship or { };
  finallyEnable = cfg.enable or false;
in
{
  config = lib.mkIf finallyEnable {
    programs.starship = {
      enable = true;
      settings = {
        "$schema" = "https://starship.rs/config-schema.json";
        format =
          ""
          + "[ ](#FF69B4)"
          + "$os"
          + "$username"
          + "$hostname"
          + "[](bg:#FF7DBE fg:#FF69B4)"
          + "$directory"
          + "[](bg:#FF91C8 fg:#FF7DBE)"
          + "$git_branch"
          + "$git_status"
          + "[](bg:#FFA5D2 fg:#FF91C8)"
          + "$c"
          + "$conda"
          + "$cpp"
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
          + "[](bg:#FFFFFF fg:#FFA5D2)"
          + "$time"
          + "[ ](fg:#FFFFFF)";
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
          format = "[$user@]($style)";
          disabled = false;
        };
        hostname = {
          ssh_only = false;
          style = "bg:#FF69B4 fg:#FFFFFF";
          format = "[$hostname ]($style)";
          disabled = false;
        };
        directory = {
          style = "bg:#FF7DBE fg:#FFFFFF";
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
          style = "bg:#FF91C8 fg:#FFFFFF";
          format = "[ $symbol $branch ]($style)";
        };
        git_status = {
          style = "bg:#FF91C8 fg:#FFFFFF";
          format = "[$all_status$ahead_behind ]($style)";
        };
        c = {
          symbol = " ";
          style = "bg:#FFA5D2 fg:#FFFFFF";
          format = "[ $symbol ($version) ]($style)";
        };
        conda = {
          symbol = "🅒 ";
          style = "bg:#FFA5D2 fg:#FFFFFF";
          format = "[ $symbol$environment]($style)";
        };
        cpp = {
          symbol = " ";
          style = "bg:#FFA5D2 fg:#FFFFFF";
          format = "[ $symbol ($version) ]($style)";
        };
        elixir = {
          symbol = " ";
          style = "bg:#FFA5D2 fg:#FFFFFF";
          format = "[ $symbol ($version) ]($style)";
        };
        elm = {
          symbol = " ";
          style = "bg:#FFA5D2 fg:#FFFFFF";
          format = "[ $symbol ($version) ]($style)";
        };
        golang = {
          symbol = " ";
          style = "bg:#FFA5D2 fg:#FFFFFF";
          format = "[ $symbol ($version) ]($style)";
        };
        gradle = {
          symbol = " ";
          style = "bg:#FFA5D2 fg:#FFFFFF";
          format = "[ $symbol ($version) ]($style)";
        };
        haskell = {
          symbol = " ";
          style = "bg:#FFA5D2 fg:#FFFFFF";
          format = "[ $symbol ($version) ]($style)";
        };
        java = {
          symbol = " ";
          style = "bg:#FFA5D2 fg:#FFFFFF";
          format = "[ $symbol ($version) ]($style)";
        };
        julia = {
          symbol = " ";
          style = "bg:#FFA5D2 fg:#FFFFFF";
          format = "[ $symbol ($version) ]($style)";
        };
        nodejs = {
          symbol = "";
          style = "bg:#FFA5D2 fg:#FFFFFF";
          format = "[ $symbol ($version) ]($style)";
        };
        nim = {
          symbol = "󰆥 ";
          style = "bg:#FFA5D2 fg:#FFFFFF";
          format = "[ $symbol ($version) ]($style)";
        };
        rust = {
          symbol = "";
          style = "bg:#FFA5D2 fg:#FFFFFF";
          format = "[ $symbol ($version) ]($style)";
        };
        scala = {
          symbol = " ";
          style = "bg:#FFA5D2 fg:#FFFFFF";
          format = "[ $symbol ($version) ]($style)";
        };
        time = {
          disabled = false;
          time_format = "%R";
          style = "bg:#FFFFFF fg:#FFA5D2";
          format = "[  $time ]($style)";
        };
      };
    };
  };
}
