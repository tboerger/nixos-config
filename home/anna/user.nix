{ pkgs, lib, config, options, ... }:
with lib;

{
  users = {
    users = {
      anna = {
        uid = 10001;
        description = "Anna Boerger";
        shell = pkgs.zsh;
        isNormalUser = true;
        hashedPasswordFile = config.age.secrets."users/anna/password".path;
        extraGroups = [
          "audio"
          "video"
          "networkmanager"
        ];
      };
    };
  };

  age.secrets."users/anna/password" = {
    file = ../../secrets/users/anna/password.age;
  };
}
