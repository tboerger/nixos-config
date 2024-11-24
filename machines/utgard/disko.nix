{ ... }:

{
  disko = {
    devices = {
      disk = {
        disk1 = {
          type = "disk";
          device = "/dev/disk/by-path/pci-0000:00:1f.2-ata-1.0";

          content = {
            type = "gpt";

            partitions = {
              ESP = {
                type = "EF00";
                size = "1G";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                };
              };

              primary = {
                size = "100%";
                content = {
                  type = "lvm_pv";
                  vg = "system";
                };
              };
            };
          };
        };

        disk2 = {
          type = "disk";
          device = "/dev/disk/by-path/pci-0000:00:1f.2-ata-2.0";

          content = {
            type = "gpt";

            partitions = {
              primary = {
                size = "100%";
                content = {
                  type = "lvm_pv";
                  vg = "tank";
                };
              };
            };
          };
        };
      };

      lvm_vg = {
        system = {
          type = "lvm_vg";

          lvs = {
            swap = {
              size = "32G";
              content = {
                type = "swap";
                resumeDevice = true;
              };
            };

            root = {
              size = "20G";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
                mountOptions = [
                  "defaults"
                ];
              };
            };

            nix = {
              size = "50G";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/nix";
              };
            };

            home = {
              size = "50G";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/home";
              };
            };

            acme = {
              size = "1G";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/var/lib/acme";
              };
            };
          };
        };

        tank = {
          type = "lvm_vg";

          lvs = {
            hass = {
              size = "10G";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/var/lib/hass";
              };
            };
          };
        };
      };
    };
  };
}
