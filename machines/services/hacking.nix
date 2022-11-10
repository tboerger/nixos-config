{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.personal.services.hacking;

in
{
  options = {
    personal = {
      services = {
        hacking = {
          enable = mkEnableOption "Hacking";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [
        burpsuite
        chisel
        chkrootkit
        john
        lynis
        metasploit
        nikto
        nmap
        thc-hydra
        wireshark
      ];
    };
  };
}
