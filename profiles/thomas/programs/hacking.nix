{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.hacking;

in
{
  options = {
    profile = {
      programs = {
        hacking = {
          enable = mkEnableOption "Hacking";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    networking = {
      hosts = {
        # "" = [ ".htb" ];
      };
    };

    environment = {
      systemPackages = with pkgs; [
        burpsuite
        chisel
        chkrootkit
        crunch
        evil-winrm
        exploitdb
        ffuf
        gobuster
        hashcat
        inetutils
        john
        lynis
        metasploit
        netcat-openbsd
        nikto
        nmap
        openvpn
        rustscan
        thc-hydra
        wireshark

        python310Packages.impacket
        python310Packages.netifaces
      ];

      etc = {
        "openvpn/thomas/hackthebox.ovpn" = {
          user = "thomas";
          group = "users";
          source = config.age.secrets."users/thomas/hackthebox".path;
          mode = "0600";
        };
      };
    };

    home-manager.users."${config.profile.username}" = { config, ... }: {
      programs = {
        zsh = {
          shellAliases = {
            "hackthebox-openvpn" = "sudo ${pkgs.openvpn}/bin/openvpn /etc/openvpn/thomas/hackthebox.ovpn";
          };
        };
      };

      home = {
        file = {
          # "Developer/hacking/responder" = {
          #   source = fetchFromGitHub {
          #     owner = "lgandx";
          #     repo = "Responder";
          #     rev = "9c303d7bd5b7d9cf2c2487075306f7877cf13d37";
          #     sha256 = "";
          #   };
          # };
          # "Developer/hacking/seclists" = {
          #   source = fetchFromGitHub {
          #     owner = "danielmiessler";
          #     repo = "SecLists";
          #     rev = "74a331a039532b8a6fd92af376cb0215a5dc0378";
          #     sha256 = "";
          #   };
          # };
          # "Developer/hacking/subdirectories" = {
          #   source = fetchFromGitHub {
          #     owner = "aels";
          #     repo = "subdirectories-discover";
          #     rev = "d6f4250560928e7bdcd31eb78cc3c0e76bb9d55f";
          #     sha256 = "";
          #   };
          # };
          # "Developer/hacking/dirbuster" = {
          #   source = fetchFromGitLab {
          #     owner = "kalilinux/packages";
          #     repo = "dirbuster";
          #     rev = "056bd88cbd0e1178f2cee43eef6865f8cde38a9c";
          #     sha256 = "";
          #   };
          # };
          # "Developer/wordlists/rockyou.txt" = {
          #   source = fetchurl {
          #     url = "https://github.com/brannondorsey/naive-hashcat/releases/download/data/rockyou.txts";
          #     sha256 = "";
          #   };
          # };
        };
      };
    };

    age.secrets."users/thomas/hackthebox" = {
      file = ../../../secrets/users/thomas/hackthebox.age;
    };
  };
}
