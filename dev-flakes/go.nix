{ ... }:
{
  perSystem = { config, self', inputs', pkgs, system, sharedUtils, ... }: 
  let
    lib = pkgs.lib;
    
    goShellHook = sharedUtils.makeShellHook {
      emoji = "🐹";
      name = "Go";
      toolCmds = [ "go" ];
      example = "go mod init myproject && go get github.com/gin-gonic/gin";
      projectDir = "Go";
    };
  in
  {
    devShells = {
      go-toolbox = pkgs.mkShell {
        name = "go-dev";
        buildInputs = sharedUtils.baseDevInputs ++ [ pkgs.go ];
        shellHook = goShellHook "Latest (${pkgs.go.version})";
      };
      
      # Aliases
      go = config.devShells.go-toolbox;
      golang = config.devShells.go-toolbox;
    };
  };
}
