{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wayland
    xwayland
    xdg-utils
    glib
    swaylock
    swayidle
    slurp # screenshot pt1
    grim # screenshot pt2, the screenshot returns (to your ~/Pictures/Screenshots folder)
    wl-clipboard
    bemenu # wayland dmenu
    mako # notif daemon
    wdisplays
    # dunst
    i3status-rust
  ];

  fonts = {
    enableDefaultPackages = false;
    packages = with pkgs; [
      font-awesome
      font-awesome_4
    ];
  };

  services = {
    dbus.enable = true;
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # gtk portal needed to make gtk apps happy
    extraPortals = [
      pkgs.xdg-desktop-portal
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  programs = {
    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
    };
    nm-applet = {
      enable = true;
    };
    dconf = {
      enable = true;
    };
  };
}
