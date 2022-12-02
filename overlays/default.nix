self: super:

{
  # citrix_workspace = super.citrix_workspace.overrideAttrs (old: {
  #   src = super.fetchurl {
  #     name = "linuxx64-22.7.0.20.tar.gz";
  #     url = "https://owncloud.boerger.ws/s/zN0Qn7e4mKuu7Tf/download";
  #     hash = "sha256-oX5EeK0+rEsMvJ+3vg26J1g5O6LTtqgrMHT/BTWGxfU=";
  #   };
  # });

  vscode-extensions = self.lib.recursiveUpdate super.vscode-extensions {
    dzhavat.bracket-pair-toggler = self.vscode-utils.extensionFromVscodeMarketplace {
      name = "bracket-pair-toggler";
      publisher = "dzhavat";
      version = "0.0.2";
      sha256 = "sha256-2u+bdXU9nU1C8X3hpi7FfI2en4mlgWRPIVzcZrgGzPo=";
    };
  };

  protoc-gen-openapiv2 = super.callPackage ./protoc-gen-openapiv2 { };
  tailscale-systray = super.callPackage ./tailscale-systray { };
}
