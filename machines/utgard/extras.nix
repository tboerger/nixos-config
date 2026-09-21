{
  config,
  lib,
  pkgs,
  ...
}:

{
  boot = {
    swraid = {
      mdadmConf = ''
        MAILADDR = hostmaster@boerger.ws
        MAILFROM = root@utgard.boerger.ws
      '';
    };
  };
}
