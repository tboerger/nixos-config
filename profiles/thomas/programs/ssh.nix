{ pkgs, ... }:

{
  enable = false;

  matchBlocks = {
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
