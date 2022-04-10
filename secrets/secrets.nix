let
  thomas = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINaQYR0/Oj6k1H03kshz2J7rlGCaDSuaGPhhOs9FcZfn";
  users = [ thomas ];

  utgard = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN02izetkp+Wru4KE0ZASwOcjJfXr3U0H/Q/i0fjdgJ7";
  systems = [ utgard ];
in
{
  "services/acme/credentials.age".publicKeys = users ++ systems;
  "services/dyndns/password.age".publicKeys = users ++ systems;
}
