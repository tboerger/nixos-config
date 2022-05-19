{ pkgs, lib, config, options, ... }:

let
  cfg = config.services.heimdall;

in
{
  options = with lib; {
    services.heimdall = {
      enable = mkEnableOption "Heimdall";
    };
  };

  config = with lib; mkIf cfg.enable {
    # virtualisation = {
    #   oci-containers = {
    #     containers = {
    #       heimdall = {
    #         image = "ghcr.io/linuxserver/heimdall:version-2.4.7";
    #         autoStart = true;

    #         extraOptions = [
    #           "--name heimdall"
    #         ];

    #         volumes = [
    #           "/var/lib/heimdall:/config"
    #         ];

    #         ports = [
    #           "8011:80/tcp"
    #         ];

    #         environment = {

    #           FOO = "bar";

    #         };
    #       };
    #     };
    #   };
    # };
  };
}
