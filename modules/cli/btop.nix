{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    # btop
    btop-rocm
  ];
}
