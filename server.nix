{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./google-compute-image.nix
  ];

  users.users.admin = {
    isNormalUser = true;
    extraGroups = ["wheel" "adm" "docker" "google-sudoers"];
  };

  environment.systemPackages = with pkgs; [
    git
    nvim
    tmux
  ];

  security.sudo.wheelNeedsPassword = false;
  time.timeZone = "UTC";
  networking.hostName = "<redacted>";
  system.stateVersion = "25.11";
}
