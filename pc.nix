{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    ./pc-hardware.nix
    ./cli.nix
    ./options.nix
    ./common.nix
    ./dev.nix
    ./apps.nix
    ./wm.nix
    ./audio.nix
  ];

  username = "bucheye";
  networking.hostName = "pc";
  system.stateVersion = "25.05";
}
