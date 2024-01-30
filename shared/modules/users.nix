{ pkgs, lib, config, options, ... }:
with lib;

{
  config = {
    users = {
      defaultUserShell = pkgs.zsh;
      mutableUsers = false;

      users = {
        root = {
          shell = pkgs.zsh;
          hashedPasswordFile = config.age.secrets."users/root/password".path;
          openssh = {
            authorizedKeys = {
              keys = [
                "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINaQYR0/Oj6k1H03kshz2J7rlGCaDSuaGPhhOs9FcZfn Thomas Boerger"
              ];
            };
          };
        };
      };
    };

    age.secrets."users/root/password" = {
      file = ../../secrets/users/root/password.age;
    };
  };
}
