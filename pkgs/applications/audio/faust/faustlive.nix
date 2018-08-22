{ stdenv
, llvm
, gnumake
, qt59
, libqrencode
, libmicrohttpd
, libjack2
, faust
, curl
, bc
, alsaLib
, gnused
, coreutils
, which 
}:

stdenv.mkDerivation rec {
    name = "faustlive-${version}";
    version = "2017-12-05";
    src = builtins.fetchGit {
        url = "git://github.com/grame-cncm/faustlive.git";
        ref = "281fcb852dcd94f8c57ade1b2a7a3937542e1b2d";
    };

    meta = with stdenv.lib; {
        description = "FaustLive is a standalone just-in-time Faust compiler";
        longDescription = ''
            FaustLive is a standalone just-in-time Faust compiler. It tries to bring together the convenience of a standalone interpreted language with the efficiency of a compiled language. It's ideal for fast prototyping.
        '';
        homepage = http://faust.grame.fr/;
        license = licenses.gpl3;
    };

    buildInputs = [
        llvm gnumake qt59.qtbase libqrencode libmicrohttpd libjack2 faust curl bc alsaLib gnused coreutils which
    ]; 

    makeFlags = [ "PREFIX=$(out)" ];

    buildPhase = '' 
        substituteInPlace Build/Linux/buildversion --replace "#!/bin/bash" ""
        make
    '';
        
}

