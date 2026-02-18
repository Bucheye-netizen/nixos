{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

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
  security.rtkit.enable = true;
  services.auto-cpufreq.enable = true;

  powerManagement.enable = true;

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = ["graphical-session.target"];
      wants = ["graphical-session.target"];
      after = ["graphical-session.target"];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  services.printing.enable = true;
  services.blueman.enable = true;

  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-gnome
    xdg-desktop-portal-gtk
    xdg-desktop-portal
  ];

  services.pipewire = {
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.bucheye = {
    shell = pkgs.fish;
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
      fzf
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
      sox
      alsa-utils
      lazygit
      tokei
      dconf-editor
      zip
      unzip
      usbimager
      typst
      tinymist
      halloy
      fractal
      gnome-keyring
      dig
      shellcheck
      cpufetch
      ruff
      zathura
      tombi
      nix-tree
      baobab
      efibooteditor
      perlnavigator
      trashy
      hyprpicker
      (texliveMedium.withPackages (
        ps:
          with ps; [
            enumitem
          ]
      ))
      pandoc
      unixtools.netstat
      netcat
      sshfs
      fuse
      kdePackages.dolphin
      gdb
      lazygit
      steam
      ffmpeg
      jq
      exiftool
      fish-lsp
      google-cloud-sdk
      gnome-disk-utility
      abiword
      libreoffice
      pomodoro-gtk
      clang
      clang-manpages
    ];
  };

  programs.java.enable = true;
  programs.kdeconnect = {
    enable = true;
  };
  programs.dconf.enable = true;
  programs.niri.enable = true;
  programs.fish.enable = true;
  programs.firefox.enable = true;
  programs.nix-ld.enable = true;

  environment.variables = {
    EDITOR = "hx";
    VISUAL = "hx";
    TERMINAL = "kitty";
    GDK_BACKEND = "wayland";
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    man-pages
    man-pages-posix
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
