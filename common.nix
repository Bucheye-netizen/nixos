{
  config,
  lib,
  pkgs,
  ...
}: {
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;

  # DC: America/New_York, RACINE: America/Chicago, ET: Europe/Amsterdam
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  hardware.bluetooth.enable = true;

  fonts.packages = with pkgs; [
    source-serif-pro
    noto-fonts
    stix-two
    lmodern
    nerd-fonts.jetbrains-mono
    nerd-fonts.iosevka-term
    times-newer-roman
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts.monospace = ["JetBrainsMono NF"];
    defaultFonts.serif = ["Source Serif Pro"];
    defaultFonts.sansSerif = ["IosevkaTerm Nerd Font"];
  };

  services.xserver.enable = true;
  qt.enable = true;

  nix.settings.experimental-features = "nix-command flakes";
  documentation.man.generateCaches = false;

  services.openssh.enable = true;
  services.xserver.xkb.layout = "us";
  services.xserver.xkb.options = "caps:escape";
  security.polkit.enable = true;
  services.auto-cpufreq.enable = true;

  powerManagement.enable = true;
  services.printing.enable = true;
  services.blueman.enable = true;
  services.gvfs.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${config.username} = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
      "input"
      "uinput"
      "audio"
      "dialout"
      "kvm"
      "adbusers"
      "fuse"
      "disks"
    ];
  };

  programs.dconf.enable = true;
  programs.nix-ld.enable = true;

  environment.systemPackages = with pkgs; [
    wl-clipboard
    uv
  ];

  nixpkgs.config.allowUnfree = true;

  nix.optimise.automatic = true;
  nix.optimise.dates = ["03:45"];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  environment.localBinInPath = true;
}
