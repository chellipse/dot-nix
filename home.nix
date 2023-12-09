{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "chelll";
  home.homeDirectory = "/home/chelll";

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
            family = "Iosevka Extended Oblique";
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
          transparent_background_colors = false;
          draw_bold_text_with_bright_colors = true;
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
        ${builtins.readFile ./nvim/init.vim}
      '';
    };
  };

  services = {
    mako = {
      enable = true;
      extraConfig = ''
        ${builtins.readFile ./mako/config}
      '';
    };
  #   xsettingsd = {
  #     enable = true;
  #     package = pkgs.xsettingsd;
  #   };
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
  };

  # only change if you've checked all the state version changes!
  home.stateVersion = "23.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
