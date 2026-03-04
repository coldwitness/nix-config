{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs = {
    fish = {
      enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    starship
  ];
}
