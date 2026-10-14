{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.firefox.enable = true;
  programs.kdeconnect.enable = true;
  programs.steam.enable = true;
  programs.gpu-screen-recorder.enable = true;

  users.users.${config.username}.packages = with pkgs; [
    obsidian
    pomodoro-gtk
    libreoffice
    sxiv
    rclone-browser
    gnome-disk-utility
    kdePackages.dolphin
    nautilus
    qbittorrent
    gnome-font-viewer
    thunderbird
    vesktop
    dconf-editor
    usbimager
    halloy
    fractal
    gnome-keyring
    efibooteditor
    zathura
    baobab
    anki
    swappy
    kdePackages.ghostwriter
    gparted
    seahorse
    timewarrior
    taskwarrior2
    gnome-text-editor
    planify
    kdePackages.gwenview
    gram
    google-chrome
    bisq2
    isync
    notmuch
    goimapnotify
    veloren
    feishin
    nicotine-plus
    kid3
    lidarr
  ];

  services.mullvad-vpn.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.qbittorrent.enable = true;
  services.fwupd.enable = true;

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

  xdg.terminal-exec = {
    enable = true;
    settings = {
      default = [
        "kitty.desktop"
      ];
    };
  };
}
