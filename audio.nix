{
  config,
  lib,
  pkgs,
  ...
}: {
  security.rtkit.enable = true;

  services.pipewire = {
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.${config.username} = {
    packages = with pkgs; [
      wireplumber
      pavucontrol
      sox
      alsa-utils
    ];
  };
}
