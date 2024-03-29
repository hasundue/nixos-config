{ pkgs, ... }:

{
  imports = [
    ./deno.nix
  ];

  home = {
    packages = with pkgs; [
      # compilers and runtimes
      bun
      gcc
      nodejs
      rustup
      zig

      # tools
      act
      gh
      lazygit
    ];
  };

  programs.gitui = {
    enable = true;
    keyConfig = builtins.readFile ./gitui.ron;
  };
}
