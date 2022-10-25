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
          passwordFile = config.age.secrets."users/root/password".path;
          openssh = {
            authorizedKeys = {
              keys = [
                "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINaQYR0/Oj6k1H03kshz2J7rlGCaDSuaGPhhOs9FcZfn thomas@osiris"
              ];
            };
          };
        };
        admin = {
          description = "Admin";
          shell = pkgs.zsh;
          isNormalUser = true;
          passwordFile = config.age.secrets."users/admin/password".path;
          uid = 1337;
          openssh = {
            authorizedKeys = {
              keys = [
                "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINaQYR0/Oj6k1H03kshz2J7rlGCaDSuaGPhhOs9FcZfn thomas@osiris"
              ];
            };
          };
          extraGroups = [
            "wheel"
            "docker"
            "libvirtd"
          ];
        };
      };
    };

    age.secrets."users/root/password" = {
      file = ../../secrets/users/root/password.age;
    };

    age.secrets."users/admin/password" = {
      file = ../../secrets/users/admin/password.age;
    };
  };
}
