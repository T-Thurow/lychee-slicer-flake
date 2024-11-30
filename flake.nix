{
  description = "Lychee Slicer";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.11";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pname = "lychee-slicer";
      version = "7.1.2";
      src = builtins.fetchurl {
        url = "https://mango-lychee.nyc3.cdn.digitaloceanspaces.com/LycheeSlicer-${version}.AppImage";
	sha256 = "sha256:1dg2hp1jp75widc1a0mrv2lbcr4mx2fyljx2n2nbb35kygblq6py";
      };
      pkgs = import nixpkgs {
        inherit system;
      };
    in {
      packages.x86_64-linux.lychee-slicer = pkgs.appimageTools.wrapType2 {
        inherit pname version src;
      };

      packages.x86_64-linux.default = self.packages.x86_64-linux.lychee-slicer;
    };
}
