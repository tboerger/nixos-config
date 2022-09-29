self: super:

{
  citrix_workspace = super.citrix_workspace.overrideAttrs (old: {
    src = super.fetchurl {
      name = "linuxx64-22.7.0.20.tar.gz";
      url = "https://owncloud.boerger.ws/s/zN0Qn7e4mKuu7Tf/download";
      hash = "sha256-oX5EeK0+rEsMvJ+3vg26J1g5O6LTtqgrMHT/BTWGxfU=";
    };
  });
}
