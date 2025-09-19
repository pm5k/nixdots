  { config, pkgs, lib, ... }:

  {
    # Place starship config file
    home.file.".config/starship/starship.toml".source = ./starship.toml;

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      history = {
        path = "${config.home.homeDirectory}/.histfile";
        size = 100000;
        save = 10000;
      };

      sessionVariables = {
        LANG = "en_GB.UTF-8";
        TERM = "xterm-256color";
        COLORTERM = "truecolor";
        LS_COLORS = "\${LS_COLORS}:ow=01;34";
        DEFAULT_USER = "$USER";
        PROJECT_HOME = "${config.home.homeDirectory}/Projects";
        EDITOR = "nvim";
        STARSHIP_CONFIG = "${config.home.homeDirectory}/.config/starship/starship.toml";
      };


      shellAliases = {
	nixrebuild = "sudo nixos-rebuild switch --flake ${config.home.homeDirectory}/.config/nixos\\#nixos";
        nixtest = "sudo nixos-rebuild test --flake ${config.home.homeDirectory}/.config/nixos\\#nixos";
        nixupdate = "cd ${config.home.homeDirectory}/.config/nixos && nix flake update && sudo nixos-rebuild switch --flake ${config.home.homeDirectory}/.config/nixos\\#nixos";

        cl = "clear";
        n = "nvim";
        zrld = "exec zsh";

        zshconf = "nvim ${config.home.homeDirectory}/.config/nixos/modules/shell/zsh.nix";
        viminit = "cd ${config.home.homeDirectory}/.config/nvim/ && nvim .";
        starconf = "nvim ${config.home.homeDirectory}/.config/starship/starship.toml";
        tmuxconf = "nvim ${config.home.homeDirectory}/.config/nixos/modules/terminal/tmux.nix";
        opnsense = "ssh opnsense";

        tmnew = "tmux new -s";
        tmkill = "tmux kill-session -t";
        tmatt = "tmux attach -t";
        tmls = "tmux ls";
        tmkall = "tmux kill-session -a";

        cd = "z";
        lt = "eza -TL 2";
        ls = "eza -loaah --git --icons --group-directories-first --time-style '+%Y-%m-%d %H:%M'";
        df = "df -h";
        du = "du -h";
        free = "free -h";
        ports = "netstat -tulpn";
        tools = "fzf-tools-widget";

        # Obsidian Editing
        obsidian = "n /mnt/e/Documents/Obsidian\\ Vault/";
        
        # Python development environments
        devpy = "nix develop ~/.config/dev-flakes";  # Latest Python (default)
        devpy312 = "nix develop ~/.config/dev-flakes\\#py312";
        devpy311 = "nix develop ~/.config/dev-flakes\\#py311"; 
        devpy310 = "nix develop ~/.config/dev-flakes\\#py310";
        
        # Node.js development environments
        devnode = "nix develop ~/.config/dev-flakes\\#node";  # Latest Node.js
        devnode22 = "nix develop ~/.config/dev-flakes\\#node22";
        devnode20 = "nix develop ~/.config/dev-flakes\\#node20";
        
        # Go development environments
        devgo = "nix develop ~/.config/dev-flakes\\#go";  # Latest Go
        
        # Other language development environments
        devrust = "nix develop ~/.config/dev-flakes\\#rust";
        devzig = "nix develop ~/.config/dev-flakes\\#zig";
        develixir = "nix develop ~/.config/dev-flakes\\#elixir";
        devphp = "nix develop ~/.config/dev-flakes\\#php";
        
        # Development environment management
        devupdate = "cd ~/.config/dev-flakes && nix flake update && echo 'Development environments updated!'";
      };

      initContent = ''
          ${builtins.readFile ./widgets.zsh}

          bindkey -v
          bindkey '^R' fzf-history-widget
          bindkey '^t' fzf-tools-widget
          setopt autocd extendedglob

          zstyle :compinstall filename '${config.home.homeDirectory}/.config/.zshrc'

          # Tab completion and autosuggestion key bindings
          bindkey '^I' complete-word        # Tab = normal completion
          bindkey '^[[Z' autosuggest-accept # Shift+Tab = accept autosuggestion


        '';
    };

    programs.starship = {
      enable = true;
      # Will automatically use ~/.config/starship/starship.toml
    };

    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
    };
  }

