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

  kubectl-ktop = super.callPackage ./kubectl-ktop { };
  kubectl-neat = super.callPackage ./kubectl-neat { };
  kubectl-oomd = super.callPackage ./kubectl-oomd { };
  kubectl-pexec = super.callPackage ./kubectl-pexec { };
  kubectl-realname-diff = super.callPackage ./kubectl-realname-diff { };
  kubectl-resource-versions = super.callPackage ./kubectl-resource-versions { };
  kubectl-view-secret = super.callPackage ./kubectl-view-secret { };
  kubectl-whoami = super.callPackage ./kubectl-whoami { };
  tailscale-systray = super.callPackage ./tailscale-systray { };
}
