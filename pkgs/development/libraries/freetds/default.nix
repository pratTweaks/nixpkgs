{ stdenv, fetchurl, autoreconfHook, pkgconfig
, openssl
, odbcSupport ? false, unixODBC ? null }:

assert odbcSupport -> unixODBC != null;

# Work is in progress to move to cmake so revisit that later

stdenv.mkDerivation rec {
  name = "freetds-${version}";
  version = "1.00.94";

  src = fetchurl {
    url    = "http://www.freetds.org/files/stable/${name}.tar.bz2";
    sha256 = "1r03ns0jp2sbbivys5bks376vbdqbnx8v764kjh74gpbajjmkksz";
  };

  buildInputs = [
    openssl
  ] ++ stdenv.lib.optional odbcSupport unixODBC;

  nativeBuildInputs = [ autoreconfHook pkgconfig ];

  enableParallelBuilding = true;

  meta = with stdenv.lib; {
    description = "Libraries to natively talk to Microsoft SQL Server and Sybase databases";
    homepage    = http://www.freetds.org;
    license     = licenses.lgpl2;
    maintainers = with maintainers; [ peterhoeg ];
    platforms   = platforms.all;
  };
}
