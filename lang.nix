{ config, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      # Rust
      gcc
      # rustc
      # cargo
      # rust-analyzer
      # rustup
      # rustfmt
      # clippy
      # C++
      # clang
    ];
  };
}
