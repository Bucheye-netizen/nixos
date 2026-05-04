{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.firefox.enable = true;
  programs.kdeconnect.enable = true;

  users.users.${config.username}.packages = with pkgs; [
    obsidian
    pomodoro-gtk
    libreoffice
    steam
    mullvad-vpn
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
    gpu-screen-recorder
    zathura
    baobab
    anki
  ];

  services.mullvad-vpn.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.qbittorrent.enable = true;

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
}
