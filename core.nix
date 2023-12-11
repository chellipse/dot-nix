{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-23.05.tar.gz";
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "daily"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services = {
    # sound
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
    udisks2.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    chelll = {
      isNormalUser = true;
      description = "Chell";
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [
      ];
    };
    hello = {
      isNormalUser = true;
      description = "Hello";
      extraGroups = [ "wheel" ];
      packages = with pkgs; [
        firefox
        hello
      ];
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment = {
    variables = {
      TEST = "${./. + "/configs/nvim"}";
    };
    systemPackages = with pkgs; [
      vim # The Nano editor is also installed by default.
      git
      vivaldi
      signal-desktop
      discord
      keepassxc
      wget
      neovim
      helix
      ripgrep # nvim
      xclip
      wl-clipboard # nvim
      nodejs # nvim
      jq # weather.sh dep
      bc # weather.sh dep
      gparted
      kitty
      gnome.gnome-tweaks
      python3
      dracula-theme
      dracula-icon-theme
      emacs
      coreutils
      fd
      clang
      gnome.zenity
    ];
  };

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      dejavu_fonts
      iosevka
      noto-fonts
      noto-fonts-emoji
      noto-fonts-lgc-plus
      nerdfonts
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Noto Serif" "DejaVu Serif" ];
        sansSerif = [ "Noto Sans" "DejaVu Sans" ];
        monospace = [ "DejaVu Sans Mono" "Noto Sans Mono" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
    fontDir = {
      enable = true;
      decompressFonts = true;
    };
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  security.polkit.enable = true;
}
