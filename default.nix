{ pkgs, ... }:
{
  boot.kernelPatches = [
    {
      name = "apple: enable interchange compression modifier";
      patch = (
        pkgs.fetchurl {
          url = "https://github.com/oliverbestmann/linux-asahi/commit/0a625598c29a3703e40a76d2ad7e843e4839f6a6.patch";
          hash = "sha256-iAkbMCOyqFxbvb1OWjbOIyYieTxBSmzA0qfOefUpdeY=";
        }
      );
    }
  ];

  nixpkgs.overlays = [
    (final: prev: {
      mesa = prev.mesa.overrideAttrs (
        f: p: {
          patches = p.patches ++ [
            (pkgs.fetchpatch {
              name = "mesa: enable interchange modifier";
              url = "https://github.com/oliverbestmann/mesa/compare/90ac874f2e81c31551b6af516f4ce87aab37cfac~3...90ac874f2e81c31551b6af516f4ce87aab37cfac.patch";
              hash = "sha256-LIrxmBYEYqQYDz600Kp2JJ+G+0B+QJvpsJxV/EmDqaA=";
            })
          ];
        }
      );
    })
  ];
}
