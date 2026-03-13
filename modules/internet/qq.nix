{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    qq
  ];
}
