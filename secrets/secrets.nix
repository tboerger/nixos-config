let
  thomas = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINaQYR0/Oj6k1H03kshz2J7rlGCaDSuaGPhhOs9FcZfn";
  users = [ thomas ];

  anubis = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII8giHHf/baGidSc0GR0IUDEm2ym/EZVbtA7p2RkQ7In";
  chnum = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFmxTCjjLZL+pFZU1A8ylZbMPF8SD5NtkJ001z2mx0i4";
  asgard = "";
  utgard = "";
  vanaheim = "";
  yggdrasil = "";
  systems = [ anubis chnum ];
in
{
  "services/acme/credentials.age".publicKeys = users ++ systems;

  "services/tailscale/authkey.age".publicKeys = users ++ systems;

  "services/shares/printer.age".publicKeys = users ++ systems;
  "services/shares/media.age".publicKeys = users ++ systems;

  "users/root/password.age".publicKeys = users ++ systems;
  "users/thomas/password.age".publicKeys = users ++ systems;
  "users/anna/password.age".publicKeys = users ++ systems;
  "users/adrian/password.age".publicKeys = users ++ systems;
  "users/tabea/password.age".publicKeys = users ++ systems;
}
