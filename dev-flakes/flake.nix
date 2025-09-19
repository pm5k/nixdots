{
  description = "Development environment toolboxes for Python, JavaScript, etc.";
  
  # Binary Cache Setup (for faster builds):
  # Add to your system configuration:
  # nix.settings.substituters = [ "https://cache.nixos.org/" "https://nix-community.cachix.org" ];
  # nix.settings.trusted-public-keys = [ 
  #   "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" 
  #   "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
  # ];

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        ./common.nix
        ./python.nix
        ./nodejs.nix
        ./go.nix
        ./rust.nix
        ./zig.nix
        ./elixir.nix
        ./php.nix
      ];
      
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
    };
}