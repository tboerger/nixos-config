{ pkgs, lib, config, options, ... }:
with lib;

{
  config = {
    age = {
      identityPaths = [
        "/etc/ssh/ssh_host_ed25519_key"
        "/etc/ssh/ssh_host_rsa_key"
      ];
    };
  };
}


identityPaths
