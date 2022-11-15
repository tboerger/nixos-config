{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.personal.services.openssh;

in
{
  options = {
    personal = {
      services = {
        openssh = {
          enable = mkEnableOption "Openssh" // {
            default = true;
          };
        };
      };
    };
  };

  config = mkIf cfg.enable {
    services = {
      openssh = {
        enable = true;
        openFirewall = true;
        permitRootLogin = "yes";

        ciphers = [
          "chacha20-poly1305@openssh.com"
          "aes256-gcm@openssh.com"
          "aes256-ctr"
          "aes128-gcm@openssh.com"
        ];

        macs = [
          "umac-128-etm@openssh.com"
          "hmac-sha2-256-etm@openssh.com"
          "hmac-sha2-512-etm@openssh.com"
          "hmac-sha2-512"
        ];

        kexAlgorithms = [
          "curve25519-sha256@libssh.org"
          "diffie-hellman-group16-sha512"
          "diffie-hellman-group18-sha512"
          "curve25519-sha256"
        ];
      };
    };
  };
}
