{ ... }:
{
  perSystem = { config, self', inputs', pkgs, system, sharedUtils, ... }: 
  let
    lib = pkgs.lib;
    
    elixirInputs = sharedUtils.makeLanguageInputs (with pkgs; [
      glibcLocales

      # Node.js for Phoenix assets
      nodejs

      # File watching for development
      inotify-tools
    ]);
    
    elixirEnvSetup = ''
      # Set up proper UTF-8 encoding for Elixir/Erlang
      export LC_ALL="en_US.UTF-8"
      export LANG="en_US.UTF-8"
      export ELIXIR_ERL_OPTIONS="+fnu"
      export ERL_AFLAGS="-kernel shell_history enabled"
      
      # Set up local Hex and Mix directories (Nix-friendly)
      mkdir -p .nix-mix .nix-hex
      export MIX_HOME="$PWD/.nix-mix"
      export HEX_HOME="$PWD/.nix-mix"
      export PATH="$MIX_HOME/bin:$HEX_HOME/bin:$PATH"
      
      echo "Phoenix install: mix archive.install hex phx_new"
      echo "New Phoenix app: mix phx.new my_app"
      echo "Database: Use Docker/external PostgreSQL as needed"
    '';
    
    elixirShellHook = sharedUtils.makeShellHook {
      emoji = "💧";
      name = "Elixir";
      toolCmds = [ "mix" ];
      example = "mix new my_app && cd my_app";
      projectDir = "Elixir";
      envSetup = [ elixirEnvSetup ];
    };
  in
  {
    devShells = {
      elixir-toolbox = pkgs.mkShell {
        name = "elixir-dev";
        buildInputs = elixirInputs ++ [ pkgs.elixir pkgs.hex ];
        shellHook = elixirShellHook "Latest (${pkgs.elixir.version})";
      };
      
      # Aliases
      elixir = config.devShells.elixir-toolbox;
    };
  };
}
