  { config, pkgs, ... }:

  {
    home.username = "tom";
    home.homeDirectory = "/home/tom";
    home.stateVersion = "25.05";
    programs.home-manager.enable = true;

    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;

      matchBlocks = {
        "*" = {
          addKeysToAgent = "yes";
        };
        opnsense = {
          hostname = "192.168.0.1";
          user = "root";
          identityFile = "~/.ssh/optiplex";
        };
      };
    };

    services.ssh-agent.enable = true;

    imports = [
      ./modules/shell/zsh.nix
      ./modules/terminal/tmux.nix
      ./modules/editors/neovim.nix 
    ];

    home.packages = with pkgs; [
      bat           # better cat with syntax highlighting {cat,syntax,highlight,preview,pager}
      claude-code   # AI assistant for coding {ai,assistant,claude,coding,development}
      delta         # syntax-highlighting pager for git diffs {git,diff,pager,syntax,color}
      difftastic    # structural diff tool that understands syntax {git,diff,syntax,code,ast}
      dust          # more intuitive disk usage analyzer {disk,usage,du,size,space}
      eza           # modern ls replacement with colors and icons {ls,list,files,tree,icons}
      fd            # simple, fast and user-friendly alternative to find {find,search,files,fast}
      fzf           # command-line fuzzy finder {fuzzy,file,find,search,filter}
      glow          # terminal markdown renderer with styling {markdown,render,preview,terminal}
      htop          # interactive process viewer and system monitor {top,process,monitor,system,cpu}
      hyperfine     # command-line benchmarking tool {benchmark,performance,timing,speed}
      jq            # lightweight and flexible command-line JSON processor {json,parse,query,filter,data}
      nodejs        # JavaScript runtime built on Chrome's V8 engine {javascript,node,runtime,server}
      pipx          # install and run Python applications in isolated environments {python,install,isolated,cli}
      python3       # high-level programming language {python,programming,scripting,development}
      ripgrep       # recursively searches directories for a regex pattern {grep,rg,search,regex,fast}
      ruff          # extremely fast Python linter and code formatter {python,lint,format,fast}
      rustup        # Rust toolchain installer and version manager {rust,compiler,toolchain,cargo}
      superfile     # Pretty fancy and modern terminal file manager {file,files,manager,file manager,super}
      tldr          # simplified and community-driven man pages {man,help,docs,examples,simple}
      unzip         # extract files from ZIP archives {zip,archive,extract,decompress}
      zoxide        # zoxide is a smarter cd command, inspired by z and autojump {cd,wd,dir,directory,list}
    ];
  }

