with import <nixpkgs> {};
with pkgs.python36Packages;

let
  stdenv = pkgs.stdenv;

in rec {

  web3 = buildPythonPackage rec {
     pname = "web3";
     version = "3.16.4";
     name = "${pname}-${version}";
     src = fetchPypi {
       inherit pname version;
       sha256 = "1sd2nzzhx77d9g5x609d5vc7rczdj3jrc39ck0ycn2lmgxmz3kxj";
     };
  
     propagatedBuildInputs = with self; [eth-abi eth-keyfile eth-tester pandoc requests];
     doCheck = false;
  
     meta = with stdenv.lib; {
       homepage = https://github.com/pipermerriam/web3.py;
       description = "A Python interface for the Ethereum blockchain";
       license = licenses.mit;
       maintainers = with maintainers; [ dc ];
     };
  };

  pymaker = buildPythonPackage rec {
    name = "pymaker";
    version = "unstable-2018-08-20";
    src = fetchFromGitHub {
      rev = "0d63eb9ef9dd0b04263a4a6c0ad72765559a3797";
      owner = "makerdao";
      repo = "pymaker";
      sha256 = "071g40a5c9hrhlzq9cpiz9bv370j3lq8gbp4p6l3g6bhrrr3macs";
    };
    doCheck = false;
    propagatedBuildInputs = with self; [ web3 eth-testrpc requests pytz ];
    
    buildPhase = ''
    '';
    
    checkPhase = ''
    '';
   
    meta = with stdenv.lib; {
      description = "Maker Python wrappers";
      homepage = https://github.com/makerdao/pymaker;
      license = licenses.agpl3;
      maintainers = with maintainers; [ dc ];
    };
  };
  
  eth-tester = buildPythonPackage rec {
     pname = "eth-tester";
     version = "0.1.0b15";
     name = "${pname}-${version}";
     src = fetchPypi {
       inherit pname version;
       sha256 = "0x87fg94s48ljkc4sbkh0l0ibadx3ww9y9kqyw1flnih9zrm7dn6";
     };
     
     checkInputs = with self; [pytest];
     propagatedBuildInputs = with self; [ hypothesis eth-utils eth-keys rlp semantic-version eth-abi ];
  
     meta = with stdenv.lib; {
       homepage = https://github.com/ethereim/eth-tester;
       description = "Tools for testing Ethereum based applications";
       license = licenses.mit;
       maintainers = with maintainers; [ dc ];
     };
   };
  
   semantic-version = buildPythonPackage rec {
     pname = "semantic_version";
     version = "2.6.0";
     name = "${pname}-${version}";
     src = fetchPypi {
       inherit pname version;
       sha256 = "1h2l9xyg1zzsda6kjcmfcgycbvrafwci283vcr1v5sbk01l2hhra";
     };
     doCheck = false;
     meta = with stdenv.lib; {
       homepage = https://github.com/rbarrois/python-semanticversion;
       description = "Tools to handle SemVer in Python";
       license = licenses.mit;
       maintainers = with maintainers; [ dc ];
     };
   };
  
   ethereum = buildPythonPackage rec {
     pname = "ethereum";
     version = "1.6.1";
     name = "${pname}-${version}";
     src = fetchPypi {
       inherit pname version;
       sha256 = "0k93zs01ff7ki835c3f7gp2sskhr3xaiqm1mkn60i60kyipslfrc";
     };
     preConfigure = ''
       substituteInPlace setup.py --replace pytest-runner==2.7 pytest-runner==2.6.2
     '';
     propagatedBuildInputs = with self; [
       pyyaml rlp pysha3 pyethash bitcoin pbkdf2 repoze_lru scrypt
       pycryptodome pytestrunner secp256k1
     ];
     doCheck = false;
     meta = with stdenv.lib; {
       homepage = https://github.com/ethereum/pyethereum;
       description = "Python core library of the Ethereum project";
       license = licenses.mit;
       maintainers = with maintainers; [ dc ];
     };
   };
  
   scrypt = buildPythonPackage rec {
     pname = "scrypt";
     version = "0.8.0";
     name = "${pname}-${version}";
     src = fetchPypi {
       inherit pname version;
       sha256 = "0830r3q8f8mc4738ngcvwhv9kih5c6zf87mzkdifzf2h6kss99fl";
     };
     buildInputs = [pkgs.openssl];
     doCheck = false;
     meta = with stdenv.lib; {
       homepage = https://bitbucket.org/mhallin/py-scrypt/src;
       description = "Bindings for the scrypt key derivation function";
       license = licenses.mit;
       maintainers = with maintainers; [ dc ];
     };
   };
  
   bitcoin = buildPythonPackage rec {
     pname = "bitcoin";
     version = "1.1.42";
     name = "${pname}-${version}";
     src = fetchPypi {
       inherit pname version;
       sha256 = "0dkjifd8d60an0jl6k9zqx9r0p5xprzlrgf4n9mlyxhwksyp1fhi";
     };
     propagatedBuildInputs = with self; [];
     meta = with stdenv.lib; {
       homepage = https://github.com/vbuterin/pybitcointools;
       description = "Bitcoin-themed Python ECC library";
       license = licenses.mit;
       maintainers = with maintainers; [ dc ];
     };
   };
  
   pyethash = buildPythonPackage rec {
     pname = "pyethash";
     version = "0.1.27";
     name = "${pname}-${version}";
     src = fetchPypi {
       inherit pname version;
       sha256 = "0618kkn2sb0a3h2pphpj2vi455xc9mil42b13zgpg7bbwaf32rpz";
     };
     propagatedBuildInputs = with self; [];
     meta = with stdenv.lib; {
       homepage = https://github.com/ethereum/ethash;
       description = "Python wrappers for the Ethereum PoW hash function";
       license = licenses.mit;
       maintainers = with maintainers; [ dc ];
     };
   };
  
   eth-abi = buildPythonPackage rec {
     pname = "eth-abi";
     version = "0.5.0";
     name = "${pname}-${version}";
     src = fetchPypi {
       inherit pname version;
       sha256 = "13if8pzawhhym7glclsfjzsy52djzpcdkw76cgfxfcdkj11m27ff";
     };
  
     checkInputs = with self; [pytest];
     propagatedBuildInputs = with self; [parsimonious08 eth-utils];
  
     meta = with stdenv.lib; {
       homepage = https://github.com/ethereum/eth-abi;
       description = "Ethereum ABI utilities for Python";
       license = licenses.mit;
       maintainers = with maintainers; [ dc ];
     };
   };
  
   eth-utils = buildPythonPackage rec {
     pname = "eth-utils";
     version = "0.7.3";
     name = "${pname}-${version}";
     src = fetchPypi {
       inherit pname version;
       sha256 = "1rna81ws6c4l872q80528d0p8jcfll778rcidh4881dmindb7scb";
     };
  
     checkInputs = with self; [pytest];
     propagatedBuildInputs = with self; [pandoc eth-hash pysha3 cytoolz pylru rlp];
  
     meta = with stdenv.lib; {
       homepage = https://github.com/ethereum/eth-utils;
       description = "Ethereum utilities for Python";
       license = licenses.mit;
       maintainers = with maintainers; [ dc ];
     };
   };
   
   eth-keyfile = buildPythonPackage rec {
     pname = "eth-keyfile";
     version = "0.4.1";
     name = "${pname}-${version}";
     src = fetchPypi {
       inherit pname version;
       sha256 = "1y4ch8wrijl7qadlxgi6a317bdn1jxfbh853aaib0kvsm4f36asi";
     };
  
     checkInputs = with self; [pytest];
     propagatedBuildInputs = with self; [eth-keys];
  
     meta = with stdenv.lib; {
       homepage = https://github.com/ethereum/eth-keyfile;
       description = "A library for handling the encrypted keyfiles used to store ethereum private keys";
       license = licenses.mit;
       maintainers = with maintainers; [ dc ];
     };
   };
  
   eth-keys = buildPythonPackage rec {
     pname = "eth-keys";
     version = "0.1.0b4";
     name = "${pname}-${version}";
     src = fetchPypi {
       inherit pname version;
       sha256 = "1p5ki269350q2fq0sfkdk5bs5i4w88y5jnmvqzi35np01j1w87sz";
     };
  
     checkInputs = with self; [pytest];
     propagatedBuildInputs = with self; [eth-utils];
  
     meta = with stdenv.lib; {
       homepage = https://github.com/ethereum/eth-keys;
       description = "A common API for Ethereum key operations with pluggable backends";
       license = licenses.mit;
       maintainers = with maintainers; [ dc ];
     };
   };
   
   eth-hash = buildPythonPackage rec {
     pname = "eth-hash";
     version = "0.1.0";
     name = "${pname}-${version}";
     src = fetchPypi {
       inherit pname version;
       sha256 = "1qspqfscjwl9brzz3nlf7dvpyac13cnjxrjch5d04q2m9n6livzx";
     };
  
     checkInputs = with self; [pytest];
     propagatedBuildInputs = with self; [
       pandoc pysha3 pycryptodome
     ];
  
     meta = with stdenv.lib; {
       homepage = https://github.com/ethereum/eth-hash;
       description = "The Ethereum hashing function, keccak256, sometimes (erroneously) called sha3";
       license = licenses.mit;
       maintainers = with maintainers; [ dc ];
     };
   };
   
   parsimonious08 = buildPythonPackage rec {
     pname = "parsimonious";
     version = "0.8.0";
     name = "${pname}-${version}";
     src = fetchPypi {
       inherit pname version;
       sha256 = "0sq81p00vsilvwyqpzp66vwbygp791bmyfii4hzp0mvf5bbnj25f";
     };
  
     checkInputs = with self; [pytest];
  
     meta = with stdenv.lib; {
       homepage = https://github.com/erikrose/parsimonious;
       description = "Fast arbitrary-lookahead parser written in pure Python";
       license = licenses.mit;
       maintainers = with maintainers; [ dc ];
     };
   };
  
   pysha3 = buildPythonPackage rec {
     pname = "pysha3";
     version = "1.0.2";
     name = "${pname}-${version}";
     src = fetchPypi {
       inherit pname version;
       sha256 = "17kkjapv6sr906ib0r5wpldmzw7scza08kv241r98vffy9rqx67y";
     };
  
     checkInputs = with self; [pytest];
  
     meta = with stdenv.lib; {
       homepage = https://github.com/tiran/pysha3;
       description = "SHA-3 wrapper (Keccak) for Python";
       license = licenses.psfl;
       maintainers = with maintainers; [ dc ];
     };
   };
  
   rlp = buildPythonPackage rec {
     pname = "rlp";
     version = "0.6.0";
     name = "${pname}-${version}";
     src = fetchPypi {
       inherit pname version;
       sha256 = "0d3gx4mp8q4z369s5yk1n9c55sgfw9fidbwqxq67d6s7l45rm1w7";
     };
  
     buildInputs = with self; [ pytest ];
     propagatedBuildInputs = with self; [ wheel ];
     
     meta = with stdenv.lib; {
       homepage = https://github.com/ethereum/pyrlp;
       description = "Recursive length prefix notation for Ethereum";
       license = licenses.mit;
       maintainers = with maintainers; [ dc ];
     };
   };
  
   eth-testrpc = buildPythonPackage rec {
     pname = "eth-testrpc";
     version = "1.3.0";
     name = "${pname}-${version}";
     src = fetchPypi {
       inherit pname version;
       sha256 = "1bmds2shkxxvhdksji1dxiadm95rf6f8cp7bzs0iirjrx1fyjni0";
     };
  
     doCheck = false;
     propagatedBuildInputs = with self; [werkzeug click rlp json-rpc ethereum];
  
     meta = with stdenv.lib; {
       homepage = https://github.com/pipermerriam/eth-testrpc;
       description = "Used for testing Ethereum JSON-RPC interactions";
       license = licenses.mit;
       maintainers = with maintainers; [ dc ];
     };
   };
  
   json-rpc = buildPythonPackage rec {
     pname = "json-rpc";
     version = "1.10.3";
     name = "${pname}-${version}";
     src = fetchPypi {
       inherit pname version;
       sha256 = "1195767r25mclnkz1pxr74wm0j21qqyq75pkw85fsxf9d8wj8gni";
     };
     doCheck = false; # Installs too many web servers
     meta = with stdenv.lib; {
       homepage = https://github.com/pavlov99/json-rpc;
       description = "JSON-RPC2.0 and JSON-RPC1.0 transport specification implementation";
       license = licenses.mit;
       maintainers = with maintainers; [ dc ];
     };
   };
}
