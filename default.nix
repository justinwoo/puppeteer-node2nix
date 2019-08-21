{ pkgs ? import <nixpkgs> {} }:

let
  node2nix = import ./node2nix.nix { inherit pkgs; };

  package = node2nix.package.override {
    preInstallPhases = "skipChromiumDownload";

    skipChromiumDownload = ''
      export PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=1
    '';
  };

in pkgs.stdenv.mkDerivation {
  name = "puppeteer-node2nix-demo";

  src = package;

  buildInputs = [ pkgs.makeWrapper ];

  installPhase = ''
    mkdir -p $out/bin
    ln -s $src/bin/puppeteer-node2nix $out/bin/puppeteer-node2nix

    wrapProgram $out/bin/puppeteer-node2nix \
      --set PUPPETEER_EXECUTABLE_PATH ${pkgs.chromium.outPath}/bin/chromium
  '';
}
