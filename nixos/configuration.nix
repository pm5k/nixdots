# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ config, lib, pkgs, ... }:

{ 
  imports = [
  ];
  nixpkgs.config.allowUnfree = true; 

  environment.systemPackages = with pkgs; [
    git           # distributed version control system {git,version,control,vcs,repository}
    curl          # command line tool for transferring data with URLs {http,download,api,transfer,web}
    gcc           # GNU Compiler Collection for C and C++ {c,cpp,compiler,build,gnu}
    gnumake       # tool which controls the generation of executables {make,build,automation,compile}
    cmake         # cross-platform family of tools for build automation {build,make,c,cpp,cross-platform}
    pkg-config    # system for managing library compile and link flags {library,compile,link,flags,development}
    zoxide        # smarter cd command with fuzzy finding {cd,navigation,directory,smart,fuzzy}
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  wsl.enable = true;
  wsl.defaultUser = "tom";
  wsl.docker-desktop.enable = true;

  users.users.tom.shell = pkgs.zsh;
  programs.zsh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
