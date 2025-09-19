{ ... }:
{
  perSystem = { config, self', inputs', pkgs, system, sharedUtils, ... }: 
  let
    lib = pkgs.lib;
    
    nodejsInputs = sharedUtils.makeLanguageInputs (with pkgs; [
      pnpm
      yarn
    ]);
    
    nodejsShellHook = sharedUtils.makeShellHook {
      emoji = "🟢";
      name = "Node.js";
      toolCmds = [ "node" "npm" "pnpm" "yarn" ];
      example = "pnpm init && pnpm add express typescript";
      projectDir = "JavaScript";
    };
    
    nodejsVersions = {
      "22" = { 
        pkg = pkgs.nodejs_22; 
        extras = []; 
        version = "22.x";
        aliases = [ "node22" "nodejs22" ];
      };
      "20" = { 
        pkg = pkgs.nodejs_20; 
        extras = []; 
        version = "20.x";
        aliases = [ "node20" "nodejs20" ];
      };
      "latest" = { 
        pkg = pkgs.nodejs; 
        extras = []; 
        version = "Latest (${pkgs.nodejs.version})";
        aliases = [ "node-latest" ];
      };
    };
    
    # Factory function to create Node.js development shells
    makeNodejsShell = versionKey: versionSpec: pkgs.mkShell {
      name = "nodejs${if versionKey == "latest" then "" else versionKey}-dev";
      buildInputs = nodejsInputs ++ [ versionSpec.pkg ] ++ versionSpec.extras;
      shellHook = nodejsShellHook versionSpec.version;
    };
    
    # Generate all Node.js development shells
    nodejsShells = lib.mapAttrs' (versionKey: versionSpec: {
      name = "nodejs${if versionKey == "latest" then "" else versionKey}-toolbox";
      value = makeNodejsShell versionKey versionSpec;
    }) nodejsVersions;
    
    # Generate aliases from Node.js configurations
    nodejsAliases = 
      # Main aliases (point to latest version)
      (lib.genAttrs [ "node" "nodejs" ] (alias: nodejsShells."nodejs-toolbox")) //
      # Version-specific aliases
      (lib.concatMapAttrs (versionKey: versionSpec:
        lib.genAttrs (versionSpec.aliases or []) (alias:
          nodejsShells."nodejs${if versionKey == "latest" then "" else versionKey}-toolbox"
        )
      ) nodejsVersions);
  in
  {
    devShells = nodejsShells // nodejsAliases;
  };
}
