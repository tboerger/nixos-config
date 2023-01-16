{ pkgs, lib, config, options, ... }:

{
  imports = [
    ./authy.nix
    ./browser.nix
    ./clickup.nix
    ./clockify.nix
    ./develop.nix
    ./direnv.nix
    ./discord.nix
    ./element.nix
    ./fzf.nix
    ./gnupg.nix
    ./golang.nix
    ./irc.nix
    ./joplin.nix
    ./kube.nix
    ./lastpass.nix
    ./latex.nix
    ./lens.nix
    ./lsd.nix
    ./lutris.nix
    ./mail.nix
    ./mattermost.nix
    ./minecraft.nix
    ./neovim.nix
    ./onepassword.nix
    ./playonlinux.nix
    ./readline.nix
    ./rocketchat.nix
    ./signal.nix
    ./skype.nix
    ./slack.nix
    ./steam.nix
    ./teams.nix
    ./telegram.nix
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
