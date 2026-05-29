{ fetchurl, system, ... }:
leanVersion:
let 
  hashes = import ./hashes.nix;
in
fetchurl {
  url = "https://sequencelib-cache.provables.org/dot-lake-${system}.tgz";
  hash = hashes.${system}.${leanVersion};
}