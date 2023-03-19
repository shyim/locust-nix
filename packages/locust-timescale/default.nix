{ lib
, python311
, python311Packages
, psycogreen
, fetchFromGitHub
}:

python311.pkgs.buildPythonPackage rec {
  pname = "locust-timescale";
  version = "3.1.1";

  src = fetchFromGitHub {
    owner = "shyim";
    repo = pname;
    rev = "99a29d49939b90f0cb15e53f179de4a1549d350c";
    hash = "sha256-5XaCRHoYI6N4Mvd7UEVjmscD2S2xS2aJLu/NA4dyw54=";
  };

  doCheck = false;

  propagatedBuildInputs = [
    python311Packages.psycopg2
    psycogreen
  ];

  meta = with lib; {
    description = "Locust + TimescaleDB + Grafana";
    homepage = "https://github.com/shyim/locust-timescale";
    license = licenses.mit;
    maintainers = with maintainers; [ shyim ];
  };
}