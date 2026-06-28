{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    ./lenovo-hardware.nix
    ./cli.nix
    ./options.nix
    ./common.nix
    ./dev.nix
    ./apps.nix
    ./wm.nix
    ./audio.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = ["nvidia-drm.fbdev=1" "usbcore.autosuspend=-1"];
  boot.kernelModules = [];
  boot.extraModprobeConfig = ''
    options snd-hda-intel power_save=0
    options snd-hda-intel model=auto
  '';

  hardware.enableAllFirmware = true;

  services.xserver = {
    exportConfiguration = true;
    videoDrivers = ["amdgpu" "nvidia"];
  };

  # Loooking into dynamic boost also include maybe "amdgpu" as a kernel module
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;

    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.production;

    prime = {
      nvidiaBusId = "PCI:1:0:0";
      amdgpuBusId = "PCI:5:0:0";
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
    };
  };

  users.users.${config.username}.packages = with pkgs; [
    prismlauncher
    lutris
    wineWow64Packages.stable
    winetricks
  ];

  services.pipewire.extraConfig.pipewire."92-media-consumption" = {
    "context.properties" = {
      "default.clock.rate" = 48000;
      "default.clock.quantum" = 1024;
      "default.clock.min-quantum" = 512;
      "default.clock.max-quantum" = 2048;
    };
  };

  username = "bucheye";
  networking.hostName = "lenovo";
  system.stateVersion = "25.11";
}
