{

  description = "Flake-1";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11"; # Or just `nixpkgs` for the registry
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
  let
    lib = nixpkgs.lib;
    system = "x86_64-linux";
  in {
    nixosConfigurations = {

      daily = lib.nixosSystem {
        inherit system;

        modules = [
          (./core.nix)
          (./daily.nix)
          (./sway.nix)
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.chelll = import ./home.nix;
          }
        ];
      };

      hello = lib.nixosSystem {
        inherit system;

        modules = [
          (./core.nix)
          (./hello.nix)
          (./sway.nix)
        ];
      };

    };
  };

}

