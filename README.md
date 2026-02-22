# asahi framebuffer comrpession

This flake provides a nixos module to enable scanout of compressed framebuffers
on asahi linux. Framebuffer compression is supposed to reduce memory bandwidth
and improve battery usage.

While this is somewhat experimental it does work perfectly fine on my machine
for a while now.

From the [asahi blog](https://asahilinux.org/2026/02/progress-report-6-19/):

> On top of this, Oliver has also begun working on compressed framebuffer
  support. There are currently two proprietary Apple framebuffer formats we know
  of in use on Apple Silicon SoCs; AGX has its own framebuffer format which is
  already supported in Mesa, however macOS never actually sends framebuffers in
  this format to DCP. Instead, DCP always scans out framebuffers in the “Apple
  Interchange” format for both GPU-rendered framebuffers and AVD-decoded video.
  Oliver reverse engineered this new format and added experimental support for
  it to Mesa and the DCP driver. While still a work in progress, this should
  eventually enable significant memory bandwidth and energy savings,
  particularly when doing display-heavy tasks like watching videos.

## Usage

Include the flake into your systems flake, if you have on. Alternativley, you
can copy the file `default.nix` into your repository and include it in your
nixos `configuration.nix`.

```nix
{
  inputs = {
    # [...]
    # add flake to inputs
    nixos-asahi-framebuffer-compression = {
      url = "github:oliverbestmann/nixos-asahi-framebuffer-compression";
    };
  }
  
  outputs = {
    # [...]
    apple-silicon-support,
    nixos-asahi-framebuffer-compression,
  }: {
  {
    nixosConfigurations.m1pro = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [
        apple-silicon-support.nixosModules.default
        nixos-asahi-framebuffer-compression.nixosModules.default
        # [...]
    };
  }
}
```
