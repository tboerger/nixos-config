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
          hashedPassword = "$6$i1AZZ2GnRxgVnJ0X$yfWoi.SDf4mWYRAI6AbaCUMM15OOOZsabgbLo82HgEvCH3yc97N00y5m3aQPcLZ/5QHaL4BPUFRU6Ux3/ziEE/";
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
          hashedPassword = "$6$l5FBDK2QUtR6Sfvv$N.eol4kjcwIr56wIv1iwT07qlK.gD2KU7fAwc8JLMeKLLuik2FjmzQszgglQUuLbvLPiMM39Dj8AsHxJyXwhX.";
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
  };
}
