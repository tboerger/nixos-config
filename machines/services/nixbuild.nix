{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.personal.services.nixbuild;

in
{
  options = {
    personal = {
      services = {
        nixbuild = {
          enable = mkEnableOption "Nixbuild";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    programs = {
      ssh = {
        extraConfig = ''
          Host eu.nixbuild.net
            PubkeyAcceptedKeyTypes ssh-ed25519
            IdentityFile ${config.age.secrets."services/nixbuild/sshkey".path}
        '';

        knownHosts = {
          nixbuild = {
            hostNames = [ "eu.nixbuild.net" ];
            publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPIQCZc54poJ8vqawd8TraNryQeJnvH1eLpIDgbiqymM";
          };
        };
      };
    };

    nix = {
      distributedBuilds = true;

      buildMachines = [
        {
          hostName = "eu.nixbuild.net";
          system = "x86_64-linux";
          maxJobs = 100;
          supportedFeatures = [
            "benchmark"
            "big-parallel"
          ];
        }
        {
          hostName = "eu.nixbuild.net";
          system = "aarch64-linux";
          maxJobs = 100;
          supportedFeatures = [
            "benchmark"
            "big-parallel"
          ];
        }
        {
          hostName = "eu.nixbuild.net";
          system = "armv7l-linux";
          maxJobs = 100;
          supportedFeatures = [
            "benchmark"
            "big-parallel"
          ];
        }
      ];
    };

    age.secrets."services/nixbuild/sshkey" = {
      file = ../../secrets/services/nixbuild/sshkey.age;
    };
  };
}
