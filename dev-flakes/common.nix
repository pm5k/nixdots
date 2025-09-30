{ ... }:
{
  perSystem = { config, self', inputs', pkgs, system, ... }: 
  let
    lib = pkgs.lib;
    # Base development inputs shared across all languages
    baseDevInputs = with pkgs; [ pkg-config git ];
    
    # Helper function to create language-specific inputs
    makeLanguageInputs = specific: baseDevInputs ++ specific;
    
    # Common bash functions for all development environments  
    commonDevFunctions = ''
      goto() {
        local project_dir="$1"
        # Handle project root at runtime, not build time
        local project_root="''${DEV_PROJECTS_ROOT:-$HOME/Projects}"
        local target_dir="$project_root/$project_dir"
        if [ -d "$target_dir" ]; then
          cd "$target_dir"
          echo "📁 Changed to: $(pwd)"
        else
          echo "⚠️  Directory $target_dir not found, staying in $(pwd)"
        fi
      }
      
      launch_zsh() {
        if command -v zsh >/dev/null 2>&1 && [ -z "$ZSH_VERSION" ]; then
          exec zsh
        fi
      }
    '';
    
    # Template-based shell hook generator
    makeShellHook = { emoji, name, toolCmds, example, projectDir, envSetup ? [] }: version: ''
      ${commonDevFunctions}

      clear
      printf "${emoji} ${name} ${version} Development Environment\n"
      ${lib.concatMapStrings (cmd: "echo \"${cmd}: $(${cmd} --version 2>/dev/null || echo 'Available')\"\n") toolCmds}
      echo ""
      echo "Ready for ${name} development!"
      echo "Example: ${example}"

      goto "${projectDir}"

      ${lib.concatStrings envSetup}

      launch_zsh
    '';
  in
  {
    # Export shared utilities for other modules to use
    _module.args.sharedUtils = {
      inherit baseDevInputs makeLanguageInputs makeShellHook commonDevFunctions;
    };
  };
}