{ ... }:

{
  disko = {
    devices = {
      disk = {
        disk1 = {
          type = "disk";
          device = "/dev/disk/by-path/fixme1";

          content = {
            type = "gpt";

            partitions = {
              ESP = {
                size = "1G";
                type = "EF00";
                content = {
                  type = "mdraid";
                  name = "boot";
                };
              };

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

        disk2 = {
          type = "disk";
          device = "/dev/disk/by-path/fixme2";

          content = {
            type = "gpt";

            partitions = {
              ESP = {
                size = "1G";
                type = "EF00";
                content = {
                  type = "mdraid";
                  name = "boot";
                };
              };

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
        boot = {
          type = "mdadm";
          level = 1;
          metadata = "1.2";

          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
          };
        };

        raid = {
          type = "mdadm";
          level = 0;
          metadata = "1.2";

          content = {
            type = "gpt";

            partitions = {
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

            nextcloud = {
              size = "100G";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/var/lib/nextcloud";
              };
            };







            kanidm = {
              size = "5G";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/var/lib/kanidm";
              };
            };

            photoprism = {
              size = "5G";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/var/lib/photoprism";
              };
            };

            filenrowser = {
              size = "5G";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/var/lib/filebrowser";
              };
            };

            bazarr = {
              size = "5G";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/var/lib/bazarr";
              };
            };

            lidarr = {
              size = "5G";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/var/lib/lidarr";
              };
            };

            prowlarr = {
              size = "5G";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/var/lib/prowlarr";
              };
            };

            radarr = {
              size = "5G";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/var/lib/radarr";
              };
            };

            sonarr = {
              size = "5G";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/var/lib/sonarr";
              };
            };

            sabnzbd = {
              size = "5G";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/var/lib/sabnzbd";
              };
            };

            jellyfin = {
              size = "5G";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/var/lib/jellyfin";
              };
            };

            jellyseer = {
              size = "5G";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/var/lib/jellyseer";
              };
            };

            downloads = {
              size = "1G";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/var/lib/downloads";
              };
            };

            anime = {
              size = "1G";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/var/lib/anime";
              };
            };

            bollywood = {
              size = "1G";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/var/lib/bollywood";
              };
            };

            kids = {
              size = "1G";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/var/lib/kids";
              };
            };

            movies = {
              size = "1G";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/var/lib/movies";
              };
            };

            shows = {
              size = "1G";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/var/lib/shows";
              };
            };

            music = {
              size = "1G";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/var/lib/music";
              };
            };

            photos = {
              size = "1G";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/var/lib/photos";
              };
            };

            videos = {
              size = "1G";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/var/lib/videos";
              };
            };



            minecraft = {
              size = "1G";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/var/lib/minecraft";
              };
            };
          };
        };
      };
    };
  };
}
