{ config, lib, pkgs, home-manager, stylix, ... }:

with lib;

{
  imports = [
    home-manager.nixosModules.home-manager
    stylix.nixosModules.stylix
  ];

  i18n.defaultLocale = "en_US.UTF-8";

  security = {
    sudo = {
      enable = true;
      wheelNeedsPassword = false;
    };
  };

  system = {
    stateVersion = "24.05";
  };

  users.groups.hasundue = {};

  users.users.hasundue = {
    createHome = true;
    description = "Shun Ueda";
    group = "hasundue";
    extraGroups = [ "wheel" ]
      ++ optionals config.networking.networkmanager.enable [ "networkmanager" ]
      ++ optionals config.programs.sway.enable [ "input" "video" ]
      ++ optionals config.sound.enable [ "audio" ]
      ++ optionals config.virtualisation.docker.enable [ "docker" ];
    isNormalUser = true;
    shell = pkgs.fish;
  };
}
