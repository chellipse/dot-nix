{

  description = "Flake-1";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.05"; # Or just `nixpkgs` for the registry
  };

  outputs = { self, nixpkgs, ... }:
  let
    lib = nixpkgs.lib;
  in {
    nixosConfigurations = {
      daily = lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          (./core.nix)

          (./hello.nix)

          (./sway.nix)
        ];
      };
    };
  };

}

