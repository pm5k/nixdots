{ ... }:
{
  perSystem = { config, self', inputs', pkgs, system, sharedUtils, ... }: 
  let
    lib = pkgs.lib;
    
    phpInputs = sharedUtils.makeLanguageInputs (with pkgs; [
      # Package manager
      php83Packages.composer
    ]);
    
    phpShellHook = sharedUtils.makeShellHook {
      emoji = "🐘";
      name = "PHP";
      toolCmds = [ "php" "composer" ];
      example = "composer create-project laravel/laravel myproject";
      projectDir = "PHP";
    };
  in
  {
    devShells = {
      php-toolbox = pkgs.mkShell {
        name = "php-dev";
        buildInputs = phpInputs ++ [ pkgs.php83 ];
        shellHook = phpShellHook "8.3 (${pkgs.php83.version})";
      };
      
      # Aliases
      php = config.devShells.php-toolbox;
    };
  };
}
