{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;

    extraPackages = with pkgs; [
      deno
      lua-language-server
      nil
      zls
    ];

    defaultEditor = true;

    plugins = with pkgs.vimPlugins; ([
      lazy-nvim
    ] ++ (with nvim-treesitter-parsers; [
      bash
      diff
      gitcommit
      go
      graphql
      javascript
      jsdoc
      json
      jsonc
      lua
      luadoc
      make
      markdown
      markdown_inline
      mermaid
      nix
      python
      regex
      ron
      rust
      scheme
      tsx
      typescript
      vim
      vimdoc
      yaml
      zig
    ]));

    vimdiffAlias = false;
    vimAlias = false;
    viAlias = false;

    withNodeJs = false;
    withPython3 = false;
    withRuby = false;
  };

  programs.git.extraConfig.core.editor = "nvim";

  home = {
    shellAliases = rec {
      nvim = "nvim --noplugin";
      nv = "${nvim}";
    };
  };

  xdg.configFile = {
    "nvim/init.lua".source = ./init.lua;
    "nvim/lua".source = ./lua;
  };
}
