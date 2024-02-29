{ config, lib, base16-schemes, neovim-nightly, stylix, ... }: 

with lib;

{
  home-manager = {
    extraSpecialArgs = { 
      inherit
        base16-schemes
        neovim-nightly
        stylix;
    };
    users.hasundue = {
      imports = [
        ./core
        ./dev
      ] ++ optionals config.programs.sway.enable [
        ./graphical
        ./graphical/sway.nix
      ];
      home.username = config.users.users.hasundue.name;
    };
  };

  nixpkgs = {
    overlays = [
      neovim-nightly.overlay
    ];
  };
}
