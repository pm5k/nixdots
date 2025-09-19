  { config, pkgs, ... }:

  {
    programs.neovim = {
      enable = true;
      defaultEditor = true;

      extraPackages = with pkgs; [
        nodejs
        python3
        ripgrep
        fd
        unzip
        curl
        wget
        git
        nodePackages.npm
        nodePackages.typescript-language-server
        lua-language-server
        tree-sitter
      ];
    };
  }
