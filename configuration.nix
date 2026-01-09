{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [./hardware-configuration.nix];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = ["nvidia-drm.fbdev=1" "usbcore.autosuspend=-1"];
  boot.kernelModules = [];
  boot.extraModprobeConfig = ''
    options snd-hda-intel power_save=0
    options snd-hda-intel model=auto
  '';

  hardware.enableAllFirmware = true;

  services.xserver = {
    enable = true;
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

  networking.hostName = "thoughtbox";

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  services.printing.enable = true;

  services.pipewire.extraConfig.pipewire."92-media-consumption" = {
    "context.properties" = {
      "default.clock.rate" = 48000;
      "default.clock.quantum" = 1024;
      "default.clock.min-quantum" = 512;
      "default.clock.max-quantum" = 2048;
    };
  };

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      swtpm.enable = true;
    };
  };

  users.users.bucheye = {
    isNormalUser = true;
    description = "Bucheye";
    extraGroups = ["networkmanager" "wheel" "input" "uinput" "audio" "dialout" "kvm" "adbusers"];
    packages = with pkgs; [
      cpufrequtils
      bibtex-tidy
      virt-manager
      mesa-demos
      vulkan-tools
      (texliveMedium.withPackages (
        ps:
          with ps; [
            enumitem
          ]
      ))
      lutris
      (pkgs.writeShellScriptBin "prismlauncher" ''
        unset QT_STYLE_OVERRIDE
        unset QT_QPA_PLATFORMTHEME
        exec ${pkgs.prismlauncher}/bin/prismlauncher "$@"
      '')
      loupe
    ];
    shell = pkgs.fish;
  };
}
