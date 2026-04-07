# configures the window manager and the display manager
{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.niri.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd niri-session";
        user = "bucheye";
      };
    };
  };

  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-gnome
    xdg-desktop-portal-gtk
    xdg-desktop-portal
  ];

  users.users.${config.username} = {
    packages = with pkgs; [
      dunst
      wayland-utils
      xwayland-satellite
      hyprpaper
      waybar
      hyprlock
      hypridle
      hyprpicker
      fuzzel
    ];
  };

  environment.systemPackages = with pkgs; [
    wl-clipboard
  ];

  services.hypridle.enable = true;
  services.dunst.enable = true;
}
