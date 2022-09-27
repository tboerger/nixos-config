{ pkgs, ... }:

{
  enable = false;

  matchBlocks = {
    "midgard" = {
      hostname = "192.168.1.5";
      port = 22;
      user = "thomas";
    };
    "vanaheim" = {
      hostname = "192.168.1.6";
      port = 22;
      user = "thomas";
    };
    "niflheim" = {
      hostname = "192.168.1.7";
      port = 22;
      user = "thomas";
    };
    "asgard" = {
      hostname = "192.168.1.10";
      port = 22;
      user = "thomas";
    };
    "utgard" = {
      hostname = "192.168.1.11";
      port = 22;
      user = "thomas";
    };

    "asbru" = {
      hostname = "asbru.webhippie.de";
      port = 22;
      user = "root";
      forwardAgent = true;
    };

    "*.cloudpunks.io !jumphost*.cloudpunks.io" = {
      user = "oper";
      forwardAgent = true;
      proxyJump = "tboerger@jumphost1.cloudpunks.io";
    };
    "jumphost1.cloudpunks.io" = {
      user = "tboerger";
      forwardAgent = true;
    };
    "jumphost2.cloudpunks.io" = {
      user = "tboerger";
      forwardAgent = true;
    };
  };
}
