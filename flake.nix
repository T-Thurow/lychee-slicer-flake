{
  description = "Lychee Slicer";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.11";
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
      overlays.default = final: prev: { lycheeslicer = final.callPackage ./package.nix { }; };
      packages = forEachSystem ( system: {
        lycheeslicer = pkgsBySystem.${system}.lycheeslicer;
        default = pkgsBySystem.${system}.lycheeslicer;
      });
    };
}
