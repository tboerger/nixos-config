{ pkgs, lib, config, options, ... }:
with lib;

{
  users = {
    users = {
      adrian = {
        uid = 10002;
        description = "Adrian Boerger";
        shell = pkgs.zsh;
        isNormalUser = true;
        hashedPasswordFile = config.age.secrets."users/adrian/password".path;
        extraGroups = [
          "audio"
          "video"
          "networkmanager"
        ];
      };
    };
  };

  age.secrets."users/adrian/password" = {
    file = ../../secrets/users/adrian/password.age;
  };
}
