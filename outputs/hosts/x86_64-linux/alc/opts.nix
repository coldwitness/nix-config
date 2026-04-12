{
  inputs,
  hostName,
  ...
}:
let
  vars = import ../../../../vars { inherit inputs; };
  optSets = import ../../../optSets { inherit inputs; };
  functions = import ../../../../functions { inherit inputs; };
  predefinedOptSetsList = [
    optSets.baseEnv
    optSets.baseUsers
  ];
  customOptSets = {
    nixConfigPath = "/home/admin/workspace/nix-config";
    cli = {
      bat.enable = true;
      eza.enable = true;
      fzf.enable = true;
      ssh.enable = true;
      tmux.enable = true;
      yazi.enable = true;
      btop.enable = true;
      starship.enable = true;
      fastfetch.enable = true;
      nix.substituters = [
        "https://mirror.sjtu.edu.cn/nix-channels/store"
        "https://cache.nixos.org"
      ];
    };
    i18n = {
      locale = vars.localeTypes.en-us;
    };
    shell = {
      fish.enable = true;
    };
    service = {
      frp.enable = true;
      openssh.enable = true;
      zerotierone.enable = true;
      rustdesk-server.enable = true;
    };
    hardware = {
      zram.enable = true;
      graphics = {
        type = vars.gpuTypes.none;
      };
      networking = {
        domain = "";
        inherit hostName;
        networkmanager.enable = false;
        firewall = {
          enable = false;
        };
      };
      boot-loader = {
        efiSysMountPoint = "/boot/efi";
        type = vars.bootLoaderTypes.systemd-boot;
      };
    };
  };
  opts = functions.mergeOptSetsList customOptSets predefinedOptSetsList;
in
opts
