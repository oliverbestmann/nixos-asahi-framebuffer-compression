{
  description = "Provides patches to enable compressed framebuffer scanout with asahi linux";

  outputs =
    { ... }:
    {
      nixosModules = {
        default = ./default.nix;
      };
    };
}
