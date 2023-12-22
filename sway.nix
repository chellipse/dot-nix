{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wayland
    wayland-utils
    wayland-protocols
    yaml-cpp # needed for wl-bouncer
    xwayland
    xdg-utils
    glib
    swaylock
    swayidle
    swaybg
    slurp # screenshot pt1
    grim # screenshot pt2, the screenshot returns (to your ~/Pictures/Screenshots folder)
    wl-clipboard
    bemenu # wayland dmenu
    mako # notif daemon
    wdisplays
    i3status-rust
    pulseaudioFull # required for sway binds
    networkmanagerapplet # encludes bin/nm-applet
  ];

  fonts = {
    packages = with pkgs; [
      font-awesome # over lapping icons with nerdfonts
      font-awesome_4 # over lapping icons with nerdfonts
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
    regreet = {
      enable = true;
      settings = {
        background = {
          path = "/home/chelll/.config/sway/backgrounds/nixos/nix-wallpaper-simple-blue.png";
          fit = "Cover";
        };
        GTK = {
          application_prefer_dark_theme = true;
          font_name = "Noto Sans 12";
          cursor_theme_name = "Bibata-Original-Ice";
          icon_theme_name = "Dracula";
          theme_name = "Dracula";
        };
      };
    };
  };
}
