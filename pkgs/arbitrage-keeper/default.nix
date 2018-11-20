with import <nixpkgs> {};
with python36Packages;

let pymaker = import ../pymaker/default.nix;

in buildPythonApplication rec {
  version = "unstable-2018-08-20";
  name = "arbitrage-keeper";

  src = fetchFromGitHub {
    rev = "2401fd516b72941e1eeb665ba4a88a4a79db530f";
    owner = "makerdao";
    repo = "arbitrage-keeper";
    sha256 = "0f24z394wr5d9rhn7g1a5h6i5n9nqk45mr4cvvw0dj8g4j9z4qsx";
  };

  patches = [ ./setup.patch ];

  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/${python.sitePackages}
    cp -r arbitrage_keeper $out/${python.sitePackages}
    cp bin/* $out/bin
  '';

  fixupPhase = ''
    for x in $out/bin/*; do wrapProgram "$x" \
      --set PYTHONPATH "$PYTHONPATH:$out/${python.sitePackages}" \
      --set PATH ${python}/bin:$PATH
    done
  '';


  doCheck = false;
  propagatedBuildInputs = [ networkx pymaker ];

  meta = with stdenv.lib; {
    description = "Maker Arbitrage keeper";
    homepage = https://github.com/makerdao/arbitrage-keeper;
    license = licenses.agpl3;
    maintainers = with maintainers; [ dc ];
  };
}
