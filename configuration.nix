# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking.hostName = "nixos"; # Define your hostname.

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # time.timeZone = "Europe/Amsterdam";

  i18n.defaultLocale = "en_US.UTF-8";

  hardware.bluetooth.enable = true;

  fonts.packages = with pkgs; [
    source-serif-pro
    nerd-fonts.jetbrains-mono
    nerd-fonts.iosevka-term
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts.monospace = ["JetBrainsMono NF"];
    defaultFonts.serif = ["Source Serif Pro"];
    defaultFonts.sansSerif = ["IosevkaTerm Nerd Font"];
  };

  services.xserver.enable = true;
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd niri-session";
        user = "bucheye";
      };
    };
  };
  nix.settings.experimental-features = "nix-command flakes";
  documentation.man.generateCaches = false;

  services.qbittorrent.enable = true;
  services.openssh.enable = true;
  services.xserver.xkb.layout = "us";
  services.xserver.xkb.options = "caps:escape";
  services.gnome.gnome-keyring.enable = true;
  security.polkit.enable = true;
  services.printing.enable = true;
  services.blueman.enable = true;

  xdg.portal.extraPortals = with pkgs; [xdg-desktop-portal-gnome xdg-desktop-portal-gtk];

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.bucheye = {
    shell = pkgs.fish;
    isNormalUser = true;
    extraGroups = ["wheel"]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      helix
      nixd
      tmux
      gh
      acpi
      clang-tools
      clang-analyzer
      coreutils-full
      gcc
      gnumake
      perlcritic
      xwayland-satellite
      kitty
      fuzzel
      stow
      starship
      eza
      hyprpaper
      waybar
      hyprlock
      hypridle
      nautilus
      qbittorrent
      brightnessctl
      parted
      usbutils
      xxd
      gnome-font-viewer
      binsider
      obsidian
      nitch
      fd
      ripgrep
      thunderbird
      mailutils
      dunst
      wayland-utils
      gpu-screen-recorder
      vesktop
      btop
      wireplumber
      pavucontrol
      rustup
      php
      laravel
      bash-language-server
      alejandra
      swayimg
    ];
  };

  programs.niri.enable = true;
  programs.fish.enable = true;
  programs.firefox.enable = true;

  environment.variables = {
    EDITOR = "hx";
    VISUAL = "hx";
    TERMINAL = "kitty";
    GDK_BACKEND = "wayland";
  };

  environment.systemPackages = with pkgs; [
    wineWow64Packages.stable
    winetricks
    vim
    wget
    git
  ];

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [38626];
    allowedUDPPorts = [38626];
  };

  nixpkgs.config.allowUnfree = true;

  nix.optimise.automatic = true;
  nix.optimise.dates = ["03:45"];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  system.stateVersion = "25.11";
}
