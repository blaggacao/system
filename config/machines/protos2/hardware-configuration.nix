# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/profiles/qemu-guest.nix>
    ];

  boot.initrd.availableKernelModules = [ "ata_piix" "uhci_hcd" "virtio_pci" "virtio_blk" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "tank/root";
      fsType = "zfs";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/EF1D-21D7";
      fsType = "vfat";
    };

  fileSystems."/nix" =
    { device = "tank/root/nix";
      fsType = "zfs";
    };

  fileSystems."/var/lib" =
    { device = "tank/root/data/varlib";
      fsType = "zfs";
    };

  fileSystems."/home" =
    { device = "tank/root/data/home";
      fsType = "zfs";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/3dd5e6c5-a581-4422-b5cb-453b98f7926c"; }
    ];

  nix.maxJobs = lib.mkDefault 1;
}