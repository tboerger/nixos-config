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
        MAILFROM = root@yggdrasil.boerger.ws
      '';
    };
  };
}
