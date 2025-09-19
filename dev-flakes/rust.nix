{ ... }:
{
  perSystem = { config, self', inputs', pkgs, system, sharedUtils, ... }: 
  let
    lib = pkgs.lib;
    
    rustEnvSetup = ''
      # Add cargo bin to PATH for installed binaries
      export PATH="$HOME/.cargo/bin:$PATH"
    '';
    
    rustShellHook = sharedUtils.makeShellHook {
      emoji = "🦀";
      name = "Rust";
      toolCmds = [ "rustc" "cargo" ];
      example = "cargo init myproject && cargo add tokio";
      projectDir = "Rust";
      envSetup = [ rustEnvSetup ];
    };
  in
  {
    devShells = {
      rust-toolbox = pkgs.mkShell {
        name = "rust-dev";
        buildInputs = sharedUtils.baseDevInputs ++ [ pkgs.rustc pkgs.cargo ];
        shellHook = rustShellHook "Latest (${pkgs.rustc.version})";
      };
      
      # Aliases
      rust = config.devShells.rust-toolbox;
    };
  };
}
