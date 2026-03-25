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
        _: mp:
        (
          let
            patches = {
              "49.4" = [
                ./patches/mutter/0001-backends-native-Move-cursor-to-overlay-plane-49.4.patch
                ./patches/mutter/0002-backend-native-Use-less-padding-on-a-single-monitor-49.4.patch
                ./patches/mutter/0003-backends-native-Pass-cursor-padding-to-cursor-manage-49.4.patch
                ./patches/mutter/0004-backends-native-Fix-cursor-visibility-check-off-by-one-49.4.patch
              ];
              "49.5" = [
                ./patches/mutter/0001-backends-native-Move-cursor-to-overlay-plane-49.5.patch
                ./patches/mutter/0002-backend-native-Use-less-padding-on-a-single-monitor-49.5.patch
                ./patches/mutter/0003-backends-native-Pass-cursor-padding-to-cursor-manage-49.5.patch
                ./patches/mutter/0004-backends-native-Fix-cursor-visibility-check-off-by-one-49.5.patch
              ];
              "50.0" = [
                ./patches/mutter/0001-backends-native-Move-cursor-to-overlay-plane-50.0.patch
                ./patches/mutter/0002-backend-native-Use-less-padding-on-a-single-monitor-50.0.patch
                ./patches/mutter/0003-backends-native-Pass-cursor-padding-to-cursor-manage-50.0.patch
                ./patches/mutter/0004-backends-native-Fix-cursor-visibility-check-off-by-one-50.0.patch
              ];
            };
          in
          {
            patches = (mp.patches or [ ]) ++ patches."${mp.version}";
          }
        )
      );
    })
  ];
}
