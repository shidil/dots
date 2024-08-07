# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/9f16ce30-81cf-47f6-8824-7ad4da674885";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/E3D9-EE14";
      fsType = "vfat";
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/dc3e686d-5c74-4581-bba5-d340db6a21b5";
      fsType = "ext4";
    };

  fileSystems."/home/shidil/games" =
    { device = "/dev/disk/by-uuid/b4fc44ea-9c7b-4425-a424-44fd7f6abd13";
      fsType = "ext4";
    };
  fileSystems."/home/shidil/Media" =
    { device = "/dev/disk/by-uuid/b7279d5a-7dfd-44f6-abe6-fe9870c3d8f6";
      fsType = "ext4";
    };
  fileSystems."/mnt/vm" =
    { device = "/dev/disk/by-uuid/aed9eac3-ed8e-4d10-960a-7df28a5214ff";
      fsType = "ext4";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/3270de93-bb23-4bf3-a453-75a541a3b838"; }
    ];

  networking.hostName = "wolfden"; # Define your hostname.

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp14s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp15s0.useDHCP = lib.mkDefault true;

  nixpkgs.config.rocmSupport = true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      vaapiVdpau
      libvdpau-va-gl
      libva-utils
    ];
  };
  hardware.amdgpu = {
      opencl.enable = true; # rocm library for compute
      initrd.enable = true; # load amdgpu kernel module
  };
}
