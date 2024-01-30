{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "ksops";
  version = "4.2.1";

  src = fetchFromGitHub {
    owner = "viaduct-ai";
    repo = "kustomize-sops";
    rev = "v${version}";
    sha256 = "sha256-Jm4mA91fyXQ8eScvRGDAmCBFVqT2GP57XIBZQo/bApg=";
  };

  vendorHash = "sha256-tNYPgXFDJuNRlrVE0ywg77goNzfoWHFVzOG9mHqK3q8=";

  postInstall = ''
    mv $out/bin/kustomize-sops $out/bin/ksops
  '';

  doCheck = false;

  meta = with lib; {
    description = "A Flexible Kustomize Plugin for SOPS Encrypted Resource";
    longDescription = ''
      KSOPS can be used to decrypt any Kubernetes resource, but is most commonly
      used to decrypt encrypted Kubernetes Secrets and ConfigMaps.
    '';
    homepage = "https://github.com/viaduct-ai/kustomize-sops";
    license = licenses.asl20;
    maintainers = with maintainers; [ tboerger ];
  };
}
