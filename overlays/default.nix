self: super:

{
  vscode-extensions = self.lib.recursiveUpdate super.vscode-extensions {
    dzhavat.bracket-pair-toggler = self.vscode-utils.extensionFromVscodeMarketplace {
      name = "bracket-pair-toggler";
      publisher = "dzhavat";
      version = "0.0.3";
      sha256 = "sha256-mjsh+jwr1ygtOEiZ3juaEuxPZQxdM3QOHxO/e2ht4Ho=";
    };
    shakram02.bash-beautify = self.vscode-utils.extensionFromVscodeMarketplace {
      name = "bash-beautify";
      publisher = "shakram02";
      version = "0.1.1";
      sha256 = "sha256-pg1nGEk+cn7VlmJeDifXkXeZJLRrEFOyW0bK9W6VGfc=";
    };
    signageos.signageos-vscode-sops = self.vscode-utils.extensionFromVscodeMarketplace {
      name = "signageos-vscode-sops";
      publisher = "signageos";
      version = "0.8.0";
      sha256 = "sha256-LcbbKvYQxob2zKnmAlylIedQkJ1INl/i9DSK7MemW9Y=";
    };
  };

  vimPlugins = self.lib.recursiveUpdate super.vimPlugins {
    dockerfile-vim = self.vimUtils.buildVimPlugin {
      pname = "dockerfile-vim";
      version = "2021-09-06";
      src = self.fetchFromGitHub {
        owner = "ekalinin";
        repo = "Dockerfile.vim";
        rev = "2a31e6bcea5977209c05c728c4253d82fd873c82";
        sha256 = "sha256-MiSGZ5MJ5g37szUuo8XCbuzuAcNBSqYY6hVa/WJwLDY=";
      };
    };
    vim-vividchalk = self.vimUtils.buildVimPlugin {
      pname = "vim-vividchalk";
      version = "2019-11-13";
      src = self.fetchFromGitHub {
        owner = "tpope";
        repo = "vim-vividchalk";
        rev = "be5c6251279bfcfa55cdea8c9a8ccd7a56c8a642";
        sha256 = "sha256-G7wFjIqhHJtUDuXPIlC34C4kRJz85ytHXpVmazrN1/I=";
      };
    };
  };

  gh-dash = super.callPackage ./gh-dash { };
  gh-markdown-preview = super.callPackage ./gh-markdown-preview { };
  gh-poi = super.callPackage ./gh-poi { };

  kubectl-get-all = super.callPackage ./kubectl-get-all { };
  kubectl-images = super.callPackage ./kubectl-images { };
  kubectl-ktop = super.callPackage ./kubectl-ktop { };
  kubectl-neat = super.callPackage ./kubectl-neat { };
  kubectl-oomd = super.callPackage ./kubectl-oomd { };
  kubectl-pexec = super.callPackage ./kubectl-pexec { };
  kubectl-realname-diff = super.callPackage ./kubectl-realname-diff { };
  kubectl-resource-versions = super.callPackage ./kubectl-resource-versions { };
  kubectl-split-yaml = super.callPackage ./kubectl-split-yaml { };
  kubectl-view-secret = super.callPackage ./kubectl-view-secret { };
  kubectl-whoami = super.callPackage ./kubectl-whoami { };

  khelm = super.callPackage ./khelm { };
  ksops = super.callPackage ./ksops { };

  zcustom = super.callPackage ./zcustom { };

  clickup = super.callPackage ./clickup { };
}
