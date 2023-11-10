{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      act
      bun
      cmake
      emscripten
      deno
      lua-language-server
      nodejs
      tree-sitter
      zig
      zls
    ];
  };

  programs.gitui = {
    enable = true;
    keyConfig = builtins.readFile ./gitui.ron;
  };

  programs.gh = {
    enable = true;
    settings = {
      prompt = "disabled";
    };
    gitCredentialHelper.enable = false;
  };
}