# needs to be new enough for numpy==numpy_2
with import (builtins.fetchTarball {
  name = "nixos-unstable-2025-10-05";
  url = "https://github.com/nixos/nixpkgs/archive/e06e469c8e2d893f1f0dcb55bbd9de8904ee0cf5.tar.gz";
  sha256 = "sha256:174gj7nxcmj4l5dr1iqfr67cl14x1aw3hxqzg716pw0g1qrmjs4w";
}) {};

python3.pkgs.buildPythonApplication {
  name = "open-beam-interface";
  src = ./.;
  pyproject = true;

  nativeBuildInputs = [
    python3.pkgs.pdm-backend
  ];

  nativeCheckInput = [
    python3.pkgs.unittestCheckHook
  ];

  propagatedBuildInputs = [
    glasgow
    yosys
    nextpnr
    icestorm
  ] ++ (with python3.pkgs; [
    numpy
    tifffile
    pillow
    tomlkit
    pyqtgraph
    pyqt6
    qasync
  ]);

  check = false;

  preBuild = ''
    export PDM_BUILD_SCM_VERSION=1.0
  '';
}
