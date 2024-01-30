{ pkgs, lib, config, options, fetchurl, ... }:
with lib;

let
  cfg = config.personal.services.cloud;

in
{
  options = {
    personal = {
      services = {
        cloud = {
          enable = mkEnableOption "Cloud";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    services = {
      nextcloud = {
        enable = true;
        hostName = "cloud.boerger.ws";
        webfinger = true;
        https = true;

        # config = {
        #   overwriteProtocol = "https";
        #   adminuser = "devops";
        #   adminpassFile = "";
        #   defaultPhoneRegion = "DE";
        # };

        extraApps = { };
      };
    };
  };
}
