{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "kubectl-view-secret";
  version = "0.11.0";

  src = fetchFromGitHub {
    owner = "elsesiy";
    repo = "kubectl-view-secret";
    rev = "v${version}";
    sha256 = "sha256-IdbJQ3YCIPcp09/NORWGezqjbwktObN7TuQdq5uAN4A=";
  };

  vendorHash = "sha256-Q6OosaHDzq9a2Nt18LGiGJ1C2i1/BRYGaNEBeK0Ohiw=";

  doCheck = false;
  subPackages = [ "cmd" ];

  postInstall = ''
    mv $out/bin/cmd $out/bin/kubectl-view_secret
  '';

  meta = with lib; {
    description = "A kubectl plugin to decode Kubernetes secrets";
    homepage = "https://github.com/elsesiy/kubectl-view-secret/";
    license = licenses.mit;
    maintainers = with maintainers; [ tboerger ];
  };
}
