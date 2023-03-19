{ lib
, python311
, python311Packages
, fetchFromGitHub
}:

python311.pkgs.buildPythonPackage rec {
  pname = "psycogreen";
  version = "1.0.2";

  src = fetchFromGitHub {
    owner = "psycopg";
    repo = pname;
    rev = "rel-1.0.2";
    hash = "sha256-0DqHRbkQr56TiN3+gjBOINev+gM/uKNnv99na7Fw5J0=";
  };

  propagatedBuildInputs = with python311Packages; [
    psycopg2
    eventlet
    gevent
  ];

  meta = with lib; {
    description = "psycopg2 integration with coroutine libraries";
    homepage = "https://github.com/psycopg/psycogreen";
    license = licenses.mit;
    maintainers = with maintainers; [ shyim ];
  };
}