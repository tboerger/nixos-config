{ pkgs, lib, config, options, ... }:
with lib;

{
  users = {
    users = {
      tabea = {
        uid = 10003;
        description = "Tabea Boerger";
        shell = pkgs.zsh;
        isNormalUser = true;
        hashedPasswordFile = config.age.secrets."users/tabea/password".path;
        extraGroups = [
          "audio"
          "video"
          "networkmanager"
        ];
      };
    };
  };

  age.secrets."users/tabea/password" = {
    file = ../../secrets/users/tabea/password.age;
  };
}
