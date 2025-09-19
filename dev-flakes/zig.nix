{ ... }:
{
  perSystem = { config, self', inputs', pkgs, system, sharedUtils, ... }: 
  let
    lib = pkgs.lib;
    
    zigShellHook = sharedUtils.makeShellHook {
      emoji = "⚡";
      name = "Zig";
      toolCmds = [ "zig" ];
      example = "zig init-exe && zig build run";
      projectDir = "Zig";
    };
  in
  {
    devShells = {
      zig-toolbox = pkgs.mkShell {
        name = "zig-dev";
        buildInputs = sharedUtils.baseDevInputs ++ [ pkgs.zig ];
        shellHook = zigShellHook "Latest (${pkgs.zig.version})";
      };
      
      # Aliases
      zig = config.devShells.zig-toolbox;
    };
  };
}
