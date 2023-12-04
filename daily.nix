{ config, pkgs, ... }:

{

  programs = {
    gnome-disks = {
      enable = true;
    };
  };

  environment = {
    variables = {
      TEST = "RESULT";
    };
    systemPackages = with pkgs; [
      rustup
      cmatrix
      ranger
      zathura
      cinnamon.nemo # files
      alacritty # terminal :3
      kitty # terminal<3
      libnotify # includes notify-send
    ];
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;
}
