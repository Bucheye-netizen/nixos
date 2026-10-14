{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    ./services.nix
    ./lenovo-hardware.nix
    ./cli.nix
    ./options.nix
    ./common.nix
    ./dev.nix
    ./apps.nix
    ./wm.nix
    ./audio.nix
  ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      vulkan-loader
      vulkan-validation-layers
      nvidia-vaapi-driver
    ];
    # todo remove
    extraPackages32 = with pkgs.pkgsi686Linux; [
      vulkan-loader
    ];
  };
  boot.kernelPackages = pkgs.linuxPackages;
  boot.kernelParams = [
    "nvidia-drm.fbdev=1"
    # "usbcore.autosuspend=-1"
    "pcie_aspm=force"
  ];
  boot.extraModprobeConfig = ''
      # options snd-hda-intel power_save=1
      # options snd-hda-intel model=auto

    "options snd-hda-intel power_save=1 power_save_controller=Y"
    "options snd-hda-intel model=auto"
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
    powerManagement.finegrained = true;

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
    (lutris.override {
      extraPkgs = pkgs: [
        pkgs.vulkan-loader
        pkgs.nvidia-vaapi-driver
      ];
    })
    wineWow64Packages.stable
    winetricks
    vulkan-tools
    mesa
    ethtool
    lunar-client
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
