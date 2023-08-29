{ config, inputs, lib, modulesPath, pkgs, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
      inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x1-extreme
    ];

  # Generated by nixos-generate-config {{{

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/0f031ba0-6020-4f3f-859f-fe71a309b9a2";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/6E77-9650";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/55a12afc-7e39-4b01-b7a7-314b7083383a"; }
    ];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # }}}

  boot.loader.systemd-boot.enable = true;

  time.timeZone = "Asia/Tokyo";

  networking = {
    hostName = "x1carbon";
    networkmanager.enable = true;
  };

  sound.enable = true;

  hardware = {
    bluetooth.enable = true;
    pulseaudio.enable = true;

    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [ libva ];
      extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
    };
  };

  services.actkbd = {
    enable = true;
    bindings = [
      { keys = [ 232 ]; events = [ "key" ]; command = "brightnessctl s 10%-"; }
      { keys = [ 233 ]; events = [ "key" ]; command = "brightnessctl s +10%"; }
    ];
  };

  services.fprintd = {
    enable = true;
    tod = {
      enable = true;
      driver = pkgs.libfprint-2-tod1-vfs0090; # TODO: use a driver for vfs0097 instead
    };
  };

  security.pam = {
    services.login.fprintAuth = true;
  };
}
