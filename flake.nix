{

  description = "Flake-1";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.05"; # Or just `nixpkgs` for the registry
  };

  outputs = { self, nixpkgs, ... }:
  let
    lib = nixpkgs.lib;
    # dbus-sway-environment = pkgs.writeTextFile {
    #   name = "dbus-sway-environment";
    #   destination = "/bin/dbus-sway-environment";
    #   executable = true;

    #   text = ''
    #     dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
    #     systemctl --user stop pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
    #     systemctl --user start pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
    #   '';
    # };
    # configure-gtk = pkgs.writeTextFile {
    #   name = "configure-gtk";
    #   destination = "/bin/configure-gtk";
    #   executable = true;
    #   text = let
    #     schema = pkgs.gsettings-desktop-schemas;
    #     datadir = "${schema}/share/gsettings-schemas/${schema.name}";
    #   in ''
    #     export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
    #     gnome_schema=org.gnome.desktop.interface
    #     gsettings set $gnome_schema gtk-theme 'Dracula'
    #   '';
    # };
  in {
    nixosConfigurations = {
      daily = lib.nixosSystem {
        system = "x86_64-linux";

        modules = [

          (./configuration.nix)

          ({ pkgs, ... }: {

            environment.systemPackages = with pkgs; [
              # cmatrix
              vivaldi
              alacritty
              kitty
              wayland
              xwayland
              xdg-utils
              glib
              # dracula-theme
              # gnome3.adwaita-icon-theme
              swaylock
              swayidle
              grim
              slurp
              wl-clipboard
              bemenu
              mako
              wdisplays
              # dunst
              i3status-rust
              pulseaudio
              # dbus-sway-environment
              # configure-gtk
            ];

            fonts.fonts = with pkgs; [
              iosevka
              # noto-fonts
              # noto-fonts-cjk
              # noto-fonts-extra
              # noto-fonts-emoji
              noto-fonts-lgc-plus
              font-awesome
              font-awesome_4
            ];

            services.dbus.enable = true;
            xdg.portal = {
              enable = true;
              wlr.enable = true;
              # gtk portal needed to make gtk apps happy
              extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
            };

            programs.sway = {
              enable = true;
              wrapperFeatures.gtk = true;
            };

            programs.nm-applet = {
              enable = true;
            };

          })
        ];
      };
    };
  };

}

