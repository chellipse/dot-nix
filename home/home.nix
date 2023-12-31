{ config, pkgs, ... }:

let
  colors = import ./colors/dracula.nix { };
in
  {
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = "chelll";
    homeDirectory = "/home/chelll";
    stateVersion = "23.11"; # only change if you've checked all the state version changes!
  };

  imports = [
    (import ./neofetch.nix { inherit config colors; })
    (import ./bash-nix.nix { inherit config; })
  ];

  programs = {
    alacritty = {
      enable = true;
      package = pkgs.alacritty;
      settings = {
        window = {
          padding = {
            x = 8;
            y = 12;
          };
          opacity = 1.0;
        };
        font = {
          normal = {
            family = "Iosevka Pro Extended";
            style = "Regular";
          };
          bold = {
            style = "Bold";
          };
          italic = {
            style = "Italic";
          };
          bold_italic = {
            style = "Bold Italic";
          };
          size = 12;
        };
        colors = {
          transparent_background_colors = true;
          draw_bold_text_with_bright_colors = false;
          # Default colors
          primary = {
            background  = colors.background ;
            foreground  = colors.foreground ;
          };
          # Normal colors
          normal = {
            black   = colors.color0;
            red     = colors.color1;
            green   = colors.color2;
            yellow  = colors.color3;
            blue    = colors.color4;
            magenta = colors.color5;
            cyan    = colors.color6;
            white   = colors.color7;
          };
          # Bright colors
          bright = {
            black   = colors.color8;
            red     = colors.color9;
            green   = colors.color10;
            yellow  = colors.color11;
            blue    = colors.color12;
            magenta = colors.color13;
            cyan    = colors.color14;
            white   = colors.color15;
          };
        };
      };
    };
    neovim = {
      enable = false;
      withNodeJs = true;
      coc = {
        enable = false;
        package = pkgs.vimPlugins.coc-nvim;
        settings = {
          markdownlint.config = {
            MD013 = false;
          };
        };
      };
      extraConfig = ''
        ${builtins.readFile ./configs/nvim/init.vim}
      '';
    };
    zsh = {
      enable = true;
      enableCompletion = true;
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
    };
    waybar = {
      enable = true;
      settings = {
        mainBar = {
          layer = "top";
          position = "bottom";
          height = 35;
          margin = "7 7 3 7";
          spacing = 2;

          modules-left = [ "custom/os" "custom/hyprprofile" "battery" "backlight" "pulseaudio" "cpu" "memory" ];
          modules-center = [ "hyprland/workspaces" ];
          modules-right = [ "idle_inhibitor" "tray" "clock" ];

          "custom/os" = {
            "format" = " {} ";
            "exec" = ''echo "" '';
            "interval" = "once";
          };
          "hyprland/workspaces" = {
            "format" = "{icon}";
            "format-icons" = {
              "1" = "󰖟";
              "2" = "";
              "3" = "";
              "4" = "";
              "5" = "";
              "6" = "";
              "7" = "";
              "8" = "";
              # "scratch_term" = "_";
              # "scratch_ranger" = "_󰴉";
              # "scratch_musikcube" = "_";
              # "scratch_btm" = "_";
              # "scratch_geary" = "_";
              # "scratch_pavucontrol" = "_󰍰";
            };
            "on-click" = "activate";
            # "on-scroll-up" = "hyprctl dispatch workspace e+1";
            # "on-scroll-down" = "hyprctl dispatch workspace e-1";
          # "ignore-workspaces" = ["scratch" "-"];
        };

        "idle_inhibitor" = {
          format = "{icon}";
          format-icons = {
            activated = "󰅶";
            deactivated = "󰾪";
          };
        };
        tray = {
          "icon-size" = 21;
          "spacing" = 10;
        };
        clock = {
          "interval" = 1;
          "format" = "{:%a %Y-%m-%d %I:%M:%S %p}";
          "timezone" = "America/NewYork";
          "tooltip-format" = ''
            <big>{:%Y %B}</big>
            <tt><small>{calendar}</small></tt>'';
          };
          cpu = {
            "format" = "{usage}% ";
          };
          memory = { "format" = "{}% "; };
          backlight = {
            "format" = "{percent}% {icon}";
            "format-icons" = [ "" "" "" "" "" "" "" "" "" ];
          };
          battery = {
            "states" = {
              "good" = 95;
              "warning" = 30;
              "critical" = 15;
            };
            "format" = "{capacity}% {icon}";
            "format-charging" = "{capacity}% ";
            "format-plugged" = "{capacity}% ";
          #"format-good" = ""; # An empty format will hide the module
          #"format-full" = "";
          "format-icons" = [ "" "" "" "" "" ];
        };
        pulseaudio = {
          "scroll-step" = 1;
          "format" = "{volume}% {icon}  {format_source}";
          "format-bluetooth" = "{volume}% {icon}  {format_source}";
          "format-bluetooth-muted" = "󰸈 {icon}  {format_source}";
          "format-muted" = "󰸈 {format_source}";
          "format-source" = "{volume}% ";
          "format-source-muted" = " ";
          "format-icons" = {
            "headphone" = "";
            "hands-free" = "";
            "headset" = "";
            "phone" = "";
            "portable" = "";
            "car" = "";
            "default" = [ "" "" "" ];
          };
          "on-click" = "pypr toggle pavucontrol && hyprctl dispatch bringactivetotop";
        };
      };
    };
  };
};

services = {
  mako = {
    enable = true;
    extraConfig = ''
        ${builtins.readFile ./configs/mako/config}
    '';
  };
    # mpd-mpris = {
    #   enable = true;
    #   enableDefaultInstance = true;
    # };
  };

  gtk = {
    enable = true;
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme=0;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme=0;
    };
    theme = {
      name = "Dracula";
      package = pkgs.dracula-theme;
    };
    iconTheme = {
      name = "Dracula";
      package = pkgs.dracula-icon-theme;
    };
    cursorTheme = {
      name = "Bibata-Original-Ice";
      package = pkgs.bibata-cursors;
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Original-Ice";
    size = 16;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
