# Floorp Browser – Firefox-basiert, Security-fokussiert, stark anpassbar, vertikale Tabs
{ config, pkgs, ... }:

{
    # Floorp aus den offiziellen NixOS Paketen installieren
    home.packages = with pkgs; [
        floorp
    ];
}
