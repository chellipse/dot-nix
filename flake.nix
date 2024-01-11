{

  description = "T480 NixOS Config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11"; # Or just `nixpkgs` for the registry
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, ... }:
  let
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    # FLAKE_DIR = "/home/chelll/dot-nix";
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
          (./lang.nix) # global lang stuff
        ];
      };

      hello = lib.nixosSystem {
        inherit system;

        modules = [
          (./core.nix)
          (./daily.nix)
          (./sway.nix)
        ];
      };

    };
  };

}

