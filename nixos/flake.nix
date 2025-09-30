{
    description = "Tom's NixOS WSL Configuration";

    inputs = {
      nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
      nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

      home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      claude-code = {
        url = "github:sadjow/claude-code-nix";
        inputs.nixpkgs.follows = "nixpkgs";
      };
    };

    outputs = { self, nixpkgs, nixos-wsl, home-manager, claude-code, ... }: {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            nixos-wsl.nixosModules.default

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.tom = import ./home.nix;
              home-manager.extraSpecialArgs = { inherit claude-code; };
            }

            ./configuration.nix
          ];
        };
      };
    };
  }

