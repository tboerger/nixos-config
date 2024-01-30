{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "khelm";
  version = "2.3.0";

  src = fetchFromGitHub {
    owner = "mgoltzsche";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-Rh3goHrtoB/cPDcQqGTCCY9FHtoxCD/wJX7EtsY1KA4=";
  };

  vendorHash = "sha256-LN6Jnv/XBgHeogJoi+jcgNVG9/WDb9d/UgyuUzhiafw=";

  doCheck = false;

  meta = with lib; {
    description = "A Flexible Kustomize Plugin for Helm chart templating";
    longDescription = ''
      A Helm chart templating CLI, helm to kustomize converter, kpt function and
      kustomize plugin.
    '';
    homepage = "https://github.com/mgoltzsche/khelm";
    license = licenses.asl20;
    maintainers = with maintainers; [ tboerger ];
  };
}
