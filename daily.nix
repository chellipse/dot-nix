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
      ffmpeg
      qbittorrent
      inkscape
      gimp-with-plugins
      gnome2.pango
      vlc
      gnome.nautilus
      samba
      samba4Full
      tree
      neofetch
      cmatrix
      ranger
      zathura
      cinnamon.nemo # files
      alacritty # terminal :3
      kitty # terminal<3
      libnotify # includes notify-send
      # webp
    ];
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;
}
