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

          (./configuration.nix)

          ({ pkgs, ... }:
          let
            dbus-sway-environment = pkgs.writeTextFile {
              name = "dbus-sway-environment";
              destination = "/bin/dbus-sway-environment";
              executable = true;

              text = ''
                dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
                systemctl --user stop pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
                systemctl --user start pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
              '';
            };
            configure-gtk = pkgs.writeTextFile {
              name = "configure-gtk";
              destination = "/bin/configure-gtk";
              executable = true;
              text = let
                schema = pkgs.gsettings-desktop-schemas;
                datadir = "${schema}/share/gsettings-schemas/${schema.name}";
              in ''
                export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
                gnome_schema=org.gnome.desktop.interface
                gsettings set $gnome_schema gtk-theme 'Dracula'
              '';
            };
          in {
            environment.systemPackages = with pkgs; [
              rustup
              cmatrix
              ranger
              zathura
              vivaldi
              cinnamon.nemo # files
              alacritty # terminal :3
              kitty # terminal<3
              wayland
              xwayland
              xdg-utils
              glib
              dracula-theme
              dracula-icon-theme
              # gtk3
              gnome3.adwaita-icon-theme
              swaylock
              swayidle
              slurp # screenshot pt1
              grim # screenshot pt2, the screenshot returns (to your ~/Pictures/Screenshots folder)
              wl-clipboard
              bemenu # wayland dmenu
              mako # notif daemon
              libnotify # includes notify-send
              wdisplays
              # dunst
              i3status-rust
              pulseaudio
              libwebp
              dbus-sway-environment
              configure-gtk
            ];

            fonts = {
              enableDefaultFonts = false;
              fonts = with pkgs; [
                dejavu_fonts
                iosevka
                noto-fonts
                noto-fonts-cjk
                noto-fonts-extra
                noto-fonts-emoji
                noto-fonts-lgc-plus
                font-awesome
                font-awesome_4
              ];

              fontconfig = {
                defaultFonts = {
                  serif = [ "Noto Serif" "DejaVu Serif" ];
                  sansSerif = [ "Noto Sans" "DejaVu Sans" ];
                  monospace = [ "DejaVu Sans Mono" "Noto Sans Mono" ];
                  emoji = [ "Noto Color Emoji" ];
                };
              };
            };

            services = {
              pipewire = {
                enable = true;
                alsa.enable = true;
                pulse.enable = true;
              };
              dbus.enable = true;
              udisks2.enable = true;
            };

            xdg.portal = {
              enable = true;
              wlr.enable = true;
              # gtk portal needed to make gtk apps happy
              extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
            };

            programs = {
              sway = {
                enable = true;
                wrapperFeatures.gtk = true;
              };
              nm-applet = {
                enable = true;
              };
              gnome-disks = {
                enable = true;
              };
              dconf = {
                enable = true;
              };
            };
          })
        ];
      };
    };
  };

}

