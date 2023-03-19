{ lib
, python311
, python311Packages
, fetchFromGitHub
, roundrobin
}:

python311.pkgs.buildPythonPackage rec {
  pname = "locustio";
  version = "2.15.1";

  src = fetchFromGitHub {
    owner = "locustio";
    repo = "locust";
    rev = version;
    hash = "sha256-4308Qy0sijhMJUO+Bz+Eco5bFI6qqpEmt3Yi6BS8tXI=";
  };

  patchPhase = ''
     echo 'version = "${version}"' > locust/_version.py
  '';

  propagatedBuildInputs = with python311Packages; [
    requests
    flask-basicauth
    flask-cors
    msgpack
    gevent
    pyzmq
    roundrobin
    geventhttpclient
    psutil
    typing-extensions
    configargparse
    setuptools
  ];

  meta = with lib; {
    description = "A load testing tool";
    homepage = "https://locust.io/";
    license = licenses.mit;
    maintainers = with maintainers; [ shyim ];
  };
}
