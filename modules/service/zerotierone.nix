{
  inputs,
  ...
}:
let
  settings = import "${inputs.secrets}/zerotierone";
in
{
  services.zerotierone ={
    enable = true;
    joinNetworks = settings.joinNetworks;
  };
}
