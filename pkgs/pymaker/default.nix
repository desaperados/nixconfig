with import <nixpkgs> {};
with import ./dependencies.nix;
with python36Packages;

buildPythonApplication rec {
  version = "unstable-2018-08-20";
  name = "pymaker";
  src = fetchFromGitHub {
    rev = "ddd38fb5620797ff5486a77f878b6f043be46363";
    owner = "makerdao";
    repo = "pymaker";
    sha256 = "1ghajzzb75s50z7csjyhsw2z1yiqh6sgf6rfcnmdnsjbgsxbvpkz";
  };

  patches = [ ./setup.patch ];

  propagatedBuildInputs = [ web3 eth-testrpc requests pytz ];

  doCheck = false;

  installPhase = ''
    mkdir -p $out/${python.sitePackages}
    cp -r pymaker $out/${python.sitePackages}
  '';

  meta = with stdenv.lib; {
    description = "Maker Python wrappers";
    homepage = https://github.com/makerdao/pymaker;
    license = licenses.agpl3;
    platforms = platforms.unix;
    maintainers = with maintainers; [ dbrock ];
  };
}
