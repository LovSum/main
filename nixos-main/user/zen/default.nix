# Zen Browser – Firefox-basierter Browser (Privacy-fokussiert, minimalistisch)
# Wird über den Community-Flake github:youwen5/zen-browser-flake installiert
{ config, pkgs, zen-browser, ... }:

{
    # Zen Browser installieren (aus dem Flake-Input)
    home.packages = [
        zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
}
