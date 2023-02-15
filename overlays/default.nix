self: super:

{
  discord = super.discord.overrideAttrs (old: {
    src = super.fetchurl {
      url = "https://dl.discordapp.net/apps/linux/0.0.25/discord-0.0.25.tar.gz";
      hash = "sha256-WBcmy9fwGPq3Vs1+7lIOR7OiW/d0kZNIKp4Q5NRYBCw=";
    };
  });

  citrix_workspace = super.citrix_workspace.overrideAttrs (old: {
    src = super.fetchurl {
      name = "linuxx64-22.12.0.12.tar.gz";
      url = "https://dl.webhippie.de/misc/citrix-workspace-x64-22.12.0.12.tar.gz";
      hash = "sha256-PsWj1VJqa6wXu5d7FzVC9b3VNaU7qm3KgMg6DWEinXQ=";
    };
  });

  vscode-extensions = self.lib.recursiveUpdate super.vscode-extensions {
    dzhavat.bracket-pair-toggler = self.vscode-utils.extensionFromVscodeMarketplace {
      name = "bracket-pair-toggler";
      publisher = "dzhavat";
      version = "0.0.2";
      sha256 = "sha256-2u+bdXU9nU1C8X3hpi7FfI2en4mlgWRPIVzcZrgGzPo=";
    };
  };

  clickup = super.callPackage ./clickup { };
  clockify = super.callPackage ./clockify { };
}
