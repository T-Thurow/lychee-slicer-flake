{
  lib,
  fetchurl,
  appimageTools
}:
let
  pname = "lychee-slicer";
  version = "7.1.2";
in
appimageTools.wrapType2 {
  inherit pname version;
  src = fetchurl {
    url = "https://mango-lychee.nyc3.cdn.digitaloceanspaces.com/LycheeSlicer-${version}.AppImage";
    sha256 = "sha256:1dg2hp1jp75widc1a0mrv2lbcr4mx2fyljx2n2nbb35kygblq6py";
  };
  meta = with lib; {
    description = "Lychee 3D Slicer Software";
    homepage = "https://mango3d.io/";
    mainProgramm = "lychee-slicer";
  };
}
