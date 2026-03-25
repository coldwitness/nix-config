{
  inputs,
  ...
}:
let
  settings = import "${inputs.secrets}/frp";
in
{
  services.frp = {
    instances = {
      client = {
        enable = true;
        role = "client";
        inherit settings;
      };
    };
  };
}
