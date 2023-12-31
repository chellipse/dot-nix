{

  description = "Flake-1";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11"; # Or just `nixpkgs` for the registry
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable,home-manager, ... }:
  let
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    FLAKE_DIR = "/home/chelll/dot-nix";
  in {
    nixosConfigurations = {

      daily = lib.nixosSystem {
        inherit system;

        specialArgs = {
          pkgs-unstable = import nixpkgs-unstable {
            inherit system;
          };
        };

        modules = [
          (./core.nix) # required setup
          (./secure.nix) # security stuff
          (./unstable.nix) # pkgs-unstable
          (./daily.nix) # daily use packages
          (./sway.nix) # sway setup
          (./hyperland.nix) # hyprland setup
          (./lang.nix) # global lang stuff
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.chelll = import ./home/home.nix;
          }
        ];
      };

      hello = lib.nixosSystem {
        inherit system;

        modules = [
          (./core.nix)
          (./daily.nix)
          (./sway.nix)
          (./hyperland.nix)
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.chelll = import ./home.nix;
          }
        ];
      };

    };
  };

}

