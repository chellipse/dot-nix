{ config, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      gcc
      rustc
      cargo
      rust-analyzer
      rustup
      rustfmt
      clippy
    ];
  };
}
