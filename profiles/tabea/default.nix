{ pkgs, lib, config, options, ... }:
with lib;

let
  username = "tabea";
  fullname = "Tabea Boerger";
  desktop = config.personal.services.desktop.enable;

in
{
  imports = [
    ../modules
    ./desktop

    ../programs
    ./programs

    ../services
    ./services
  ];

  profile = {
    username = username;
  };

  users = {
    users = {
      "${username}" = {
        description = "${fullname}";
        shell = pkgs.zsh;
        isNormalUser = true;
        passwordFile = config.age.secrets."users/${username}/password".path;
        extraGroups = [
          "audio"
          "video"
          "networkmanager"
        ];
      };
    };
  };

  home-manager.users."${username}" = { config, ... }: {
    home = {
      homeDirectory = "/home/${username}";
      stateVersion = "18.09";
    };
  };

  age.secrets."users/${username}/password" = {
    file = ../../secrets/users/${username}/password.age;
  };
}
