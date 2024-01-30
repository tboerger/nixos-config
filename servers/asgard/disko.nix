{ ... }:

{
  disko = {
    devices = {
      disk = {

        disk1 = {
          type = "disk";
          device = "/dev/disk/by-path/pci-0000:00:14.1-ata-1";

          content = {
            type = "gpt";

            partitions = {
              boot = {
                size = "1G";
                type = "EF02";
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
          device = "/dev/disk/by-path/pci-0000:00:11.0-ata-1";

          content = {
            type = "gpt";

            partitions = {
              mdadm = {
                size = "100%";
                content = {
                  type = "mdraid";
                  name = "raid";
                };
              };
            };
          };
        };

        disk3 = {
          type = "disk";
          device = "/dev/disk/by-path/pci-0000:00:11.0-ata-2";

          content = {
            type = "gpt";

            partitions = {
              mdadm = {
                size = "100%";
                content = {
                  type = "mdraid";
                  name = "raid";
                };
              };
            };
          };
        };

        disk4 = {
          type = "disk";
          device = "/dev/disk/by-path/pci-0000:00:11.0-ata-3";

          content = {
            type = "gpt";

            partitions = {
              mdadm = {
                size = "100%";
                content = {
                  type = "mdraid";
                  name = "raid";
                };
              };
            };
          };
        };

        disk5 = {
          type = "disk";
          device = "/dev/disk/by-path/pci-0000:00:11.0-ata-4";

          content = {
            type = "gpt";

            partitions = {
              mdadm = {
                size = "100%";
                content = {
                  type = "mdraid";
                  name = "raid";
                };
              };
            };
          };
        };
      };

      mdadm = {
        raid = {
          type = "mdadm";
          level = 10;
          metadata = "1.2";

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
            shares = {
              size = "50G";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/var/lib/shares";
              };
            };

            photos = {
              size = "100G";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/var/lib/photos";
              };
            };

            videos = {
              size = "100G";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/var/lib/videos";
              };
            };

            printer = {
              size = "10G";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/var/lib/printer";
              };
            };

            backup = {
              size = "1000G";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/var/lib/backup";
              };
            };
          };
        };
      };
    };
  };
}
