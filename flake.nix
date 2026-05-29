{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    simple-flake.url = "github:waltermoreira/simple-flake";
  };

  outputs = inputs@{ self, simple-flake, ... }:
    simple-flake.lib.mkFlake { inherit inputs; } {
      debug = true;
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
      perSystem = { pkgs, inputs', system, ... }:
        let
          fetcher = pkgs.callPackage ./fetch-cache.nix { };
        in
        {
          packages = {
            default = fetcher "4.30.0";
          };
          lib = {
            inherit fetcher;
          };
        };
    };
}
