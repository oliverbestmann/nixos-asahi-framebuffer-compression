{ ... }:
{
  boot.kernelPatches = [
    {
      name = "apple: enable interchange compression modifier";
      patch = ./patches/linux/0001-drm-apple-support-interchange-compression.patch;
    }
    {
      name = "apple: fixup: do not check pitch for alignment";
      patch = ./patches/linux/0002-fixup-do-not-check-pitch-with-INTERCHANGE-modifier.patch;
    }
  ];

  nixpkgs.overlays = [
    (final: prev: {
      mesa = prev.mesa.overrideAttrs (
        _: pkg: {
          patches = (pkg.patches or [ ]) ++ [
            ./patches/mesa/0001-asahi-add-INTERCHANGE_COMPRESSED-modifier-for-testin.patch
            ./patches/mesa/0002-asahi-add-support-for-interchange_compressed.patch
            ./patches/mesa/0003-hk-add-support-for-interchange_compressed.patch
            ./patches/mesa/0004-fixup-agx-adjust-stride-for-interchange.patch
          ];
        }
      );

      mutter = prev.mutter.overrideAttrs (
        _: pkg: {
          patches = (pkg.patches or [ ]) ++ [
            ./patches/mutter/0001-backend-native-move-cursor-to-overlay-plane-49.4.patch
          ];
        }
      );
    })
  ];
}
