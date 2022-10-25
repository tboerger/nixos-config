{ pkgs, lib, config, options, ... }:

{
  imports = [
    ./authy.nix
    ./browser.nix
    ./clockify.nix
    ./develop.nix
    ./direnv.nix
    ./discord.nix
    ./element.nix
    ./fzf.nix
    ./gnupg.nix
    ./golang.nix
    ./kube.nix
    ./lastpass.nix
    ./latex.nix
    ./lens.nix
    ./lsd.nix
    ./lutris.nix
    ./mattermost.nix
    ./minecraft.nix
    ./neovim.nix
    ./onepassword.nix
    ./owncloud.nix
    ./playonlinux.nix
    ./readline.nix
    ./rocketchat.nix
    ./signal.nix
    ./skype.nix
    ./slack.nix
    ./steam.nix
    ./teams.nix
    ./telegram.nix
    ./thunderbird.nix
    ./tmux.nix
    ./whatsapp.nix
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
