{ lib, fetchFromGitHub, stdenv, wayland-scanner, wlr-protocols, wayland, ... }:
stdenv.mkDerivation (finalAttrs: {
  name = "wl-clicker";
  version = "0.3.1";

  nativeBuildInputs = [ wayland-scanner ];
  buildInputs = [ wlr-protocols wayland ];

  src = fetchFromGitHub {
    owner = "phonetic112";
    repo = "wl-clicker";
    rev = "v${finalAttrs.version}";
    sha256 = "0ddi383ilxqm0nvn05asn6m77sgi96fw07np95wx089a97b0mr8y";
  };

  postPatch = ''
    sed -i 's|/usr|${wlr-protocols}|g' Makefile
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    install build/wl-clicker $out/bin/wl-clicker

    runHook postInstall
  '';
})
