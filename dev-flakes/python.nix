{ ... }:
{
  perSystem = { config, self', inputs', pkgs, system, sharedUtils, ... }: 
  let
    lib = pkgs.lib;
    
    pythonInputs = sharedUtils.makeLanguageInputs (with pkgs; [
      uv
      ruff
      
      # Essential C libraries for basic Python packages
      stdenv.cc.cc.lib
      zlib
      openssl
      libffi
      readline
      sqlite
      
      # Scientific computing C libraries (numpy, pandas, scipy, etc.)
      blas
      lapack
      gfortran
      
      # Additional libraries for various Python packages
      libxml2
      libxslt
      libjpeg
      libpng
      freetype
      fontconfig
      glib
      cairo
      pango
      gdk-pixbuf
      
      # For packages that need pkg-config to find things
      pkg-config
    ]);
    
    pythonEnvSetup = ''
      # Set up environment for C extensions
      export PKG_CONFIG_PATH="${pkgs.openssl.dev}/lib/pkgconfig:${pkgs.libffi.dev}/lib/pkgconfig:$PKG_CONFIG_PATH"
      export LD_LIBRARY_PATH="${pkgs.stdenv.cc.cc.lib}/lib:${pkgs.zlib}/lib:${pkgs.openssl.out}/lib:${pkgs.libffi.out}/lib:$LD_LIBRARY_PATH"
    '';
    
    pythonShellHook = sharedUtils.makeShellHook {
      emoji = "🐍";
      name = "Python";
      toolCmds = [ "python" "uv" "ruff" ];
      example = "uv init && uv add requests click";
      projectDir = "Python";
      envSetup = [ pythonEnvSetup ];
    };
    
    pythonVersions = {
      "312" = { 
        pkg = pkgs.python312; 
        extras = with pkgs; [ python312Packages.pip python312Packages.setuptools python312Packages.wheel ];
        version = "3.12";
        aliases = [ "py312" "python312" ];
      };
      "311" = { 
        pkg = pkgs.python311; 
        extras = with pkgs; [ python311Packages.pip python311Packages.setuptools python311Packages.wheel ];
        version = "3.11";
        aliases = [ "py311" "python311" ];
      };
      "310" = { 
        pkg = pkgs.python310; 
        extras = with pkgs; [ python310Packages.pip python310Packages.setuptools python310Packages.wheel ];
        version = "3.10";
        aliases = [ "py310" "python310" ];
      };
      "latest" = { 
        pkg = pkgs.python3; 
        extras = with pkgs; [ python3Packages.pip python3Packages.setuptools python3Packages.wheel ];
        version = "Latest (${pkgs.python3.version})";
        aliases = [ "default" "latest" ];
      };
    };
    
    # Factory function to create Python development shells
    makePythonShell = versionKey: versionSpec: pkgs.mkShell {
      name = "python${if versionKey == "latest" then "" else versionKey}-dev";
      buildInputs = pythonInputs ++ [ versionSpec.pkg ] ++ versionSpec.extras;
      shellHook = pythonShellHook versionSpec.version;
    };
    
    # Generate all Python development shells
    pythonShells = lib.mapAttrs' (versionKey: versionSpec: {
      name = "python${if versionKey == "latest" then "" else versionKey}-toolbox";
      value = makePythonShell versionKey versionSpec;
    }) pythonVersions;
    
    # Generate aliases from Python configurations
    pythonAliases = 
      # Main aliases (point to latest version)
      (lib.genAttrs [ "python" "py" ] (alias: pythonShells."python-toolbox")) //
      # Version-specific aliases
      (lib.concatMapAttrs (versionKey: versionSpec:
        lib.genAttrs (versionSpec.aliases or []) (alias:
          pythonShells."python${if versionKey == "latest" then "" else versionKey}-toolbox"
        )
      ) pythonVersions);
  in
  {
    devShells = pythonShells // pythonAliases;
  };
}
