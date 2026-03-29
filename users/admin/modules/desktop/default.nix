{
  lib,
  config,
  configPath,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.desktop;
  finallyEnable = hostOptions.desktop.type != "";
in
{
  config = lib.mkIf finallyEnable {
    home.file = {
      ".gtkrc-2.0" = {
        source = config.lib.file.mkOutOfStoreSymlink "${configPath}/gtk/.gtkrc-2.0";
        force = true;
      };
      ".config/gtk-3.0" = {
        source = config.lib.file.mkOutOfStoreSymlink "${configPath}/gtk/gtk-3.0";
        force = true;
      };
      ".config/gtk-4.0" = {
        source = config.lib.file.mkOutOfStoreSymlink "${configPath}/gtk/gtk-4.0";
        force = true;
      };
      ".config/xsettingsd" = {
        source = config.lib.file.mkOutOfStoreSymlink "${configPath}/gtk/xsettingsd";
        force = true;
      };
      ".config/qt6ct" = {
        source = config.lib.file.mkOutOfStoreSymlink "${configPath}/qt6ct";
        force = true;
      };
    };
  };
}
