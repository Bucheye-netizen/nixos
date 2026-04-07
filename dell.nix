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
    ./cli.nix
    ./common.nix
    ./hardware-configuration.nix
    ./options.nix
    ./wm.nix
    ./audio.nix
    ./apps.nix
    ./dev.nix
  ];

  username = "bucheye";
  networking.hostName = "dell";
  system.stateVersion = "25.11";
}
