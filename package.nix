{
  lib,
  fetchurl,
  appimageTools
}:
let
  pname = "lycheeslicer";
  version = "7.3.2";
  src = fetchurl {
    url = "https://mango-lychee.nyc3.cdn.digitaloceanspaces.com/LycheeSlicer-${version}.AppImage";
    hash = "sha256-CmN4Q4gTGYeICIoLz0UuVlSyOstXW/yYVb4s1dT5EOc=";
  };
  appimageContents = appimageTools.extract {
    inherit pname version src;
  };
in
appimageTools.wrapType2 {
  inherit pname version src;

  extraInstallCommands = ''
    install -m 444 -D ${appimageContents}/${pname}.desktop -t $out/share/applications
    substituteInPlace $out/share/applications/${pname}.desktop \
      --replace-fail 'Exec=AppRun' 'Exec=${pname}'
    cp -r ${appimageContents}/usr/share/icons $out/share
  '';

  meta = with lib; {
    description = "Lychee 3D Slicer Software";
    homepage = "https://mango3d.io/";
    mainProgramm = "lycheeslicer";
  };
}
