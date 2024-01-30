{ ... }:

{
  disko = {
    devices = {
      disk = {
        disk1 = {
          type = "disk";
          device = "/dev/disk/by-id/ata-TOSHIBA_THNSNH512GCST_14DS100ATBAY";

          content = {
            type = "gpt";

            partitions = {
              ESK = {
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
              size = "100G";
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

            dummy1 = {
              size = "1M";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/var/lib/dummy1";
              };
            };
          };
        };
      };
    };
  };
}
