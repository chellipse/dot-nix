{ config, pkgs-unstable, ... }:

{
  environment.systemPackages = with pkgs-unstable; [
    eza
  ];
  fonts = {
    packages = with pkgs-unstable; [
      iosevka
      iosevka-bin
      nerdfonts
    ];
  };
}
