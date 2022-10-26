let
  thomas = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINaQYR0/Oj6k1H03kshz2J7rlGCaDSuaGPhhOs9FcZfn";
  users = [ thomas ];

  midgard = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICGC6aSeeKiMO9y3NMxPOh2JvvGYcyS4za+0+hSqI3Bj";
  asgard = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE89Efj2pqq83mv+psNY48iSHSyK3xU21MyubMN41ZoJ";
  utgard = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN02izetkp+Wru4KE0ZASwOcjJfXr3U0H/Q/i0fjdgJ7";
  systems = [ midgard asgard utgard ];
in
{
  "services/acme/credentials.age".publicKeys = users ++ systems;
  "services/frpc/token.age".publicKeys = users ++ systems;
  "services/mopidy/jellyfin.age".publicKeys = users ++ systems;
  "services/nixbuild/sshkey.age".publicKeys = users ++ systems;
  "services/tailscale/authkey.age".publicKeys = users ++ systems;

  "users/media/smbpasswd.age".publicKeys = users ++ systems;

  "users/media/password.age".publicKeys = users ++ systems;
  "users/printer/password.age".publicKeys = users ++ systems;
  "users/thomas/password.age".publicKeys = users ++ systems;
  "users/anna/password.age".publicKeys = users ++ systems;
  "users/adrian/password.age".publicKeys = users ++ systems;
  "users/tabea/password.age".publicKeys = users ++ systems;
}
