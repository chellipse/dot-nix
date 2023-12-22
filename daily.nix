{ config, pkgs, ... }:

{

  programs = {
    gnome-disks = {
      enable = true;
    };
  };

  services = {
    gvfs.enable = true;
    gvfs.package = pkgs.gnome.gvfs;
  };

  environment = {
    # variables = {
    # };
    systemPackages = with pkgs; [
      anki
      dropbox
      dropbox-cli
      calc
      ffmpeg
      qbittorrent
      # inkscape
      gimp-with-plugins
      gnome2.pango
      vlc
      gnome.nautilus
      samba
      samba4Full
      # tree
      neofetch
      cmatrix
      ranger
      zathura
      cinnamon.nemo-with-extensions # files
      alacritty # terminal :3
      kitty # terminal<3
      libnotify # includes notify-send
      libwebp
    ];
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;
}
