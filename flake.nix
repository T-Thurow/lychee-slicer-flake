{
  description = "Lychee Slicer";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.05";
  };

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" ];
      forEachSystem = nixpkgs.lib.genAttrs systems;
      overlayList = [ self.overlays.default ];
      pkgsBySystem = forEachSystem ( system:
        import nixpkgs {
           inherit system;
           overlays = overlayList;
        }
      );
    in {
      overlays.default = final: prev: { lychee-slicer = final.callPackage ./package.nix { }; };
      packages = forEachSystem ( system: {
        lychee-slicer = pkgsBySystem.${system}.lychee-slicer;
        default = pkgsBySystem.${system}.lychee-slicer;
      });
    };
}
