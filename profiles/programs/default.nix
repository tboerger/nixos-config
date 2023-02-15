{ pkgs, lib, config, options, ... }:

{
  imports = [
    ./authy.nix
    ./browser.nix
    ./clickup.nix
    ./clockify.nix
    ./develop.nix
    ./direnv.nix
    ./fzf.nix
    ./gnupg.nix
    ./golang.nix
    ./joplin.nix
    ./kube.nix
    ./lastpass.nix
    ./latex.nix
    ./lens.nix
    ./lsd.nix
    ./lutris.nix
    ./mail.nix
    ./messages.nix
    ./minecraft.nix
    ./neovim.nix
    ./onepassword.nix
    ./playonlinux.nix
    ./readline.nix
    ./steam.nix
    ./tmux.nix
    ./wine.nix
    ./yed.nix
    ./zathura.nix
  ];

  options = with lib; {
    profile = {
      programs = { };
    };
  };
}
