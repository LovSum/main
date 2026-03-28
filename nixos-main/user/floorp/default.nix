# Floorp Browser – Firefox-basiert, Security-fokussiert, stark anpassbar, vertikale Tabs
{ config, pkgs, ... }:

{
    # Floorp aus den offiziellen NixOS Paketen installieren
    home.packages = with pkgs; [
        floorp-bin
    ];

    # Floorp als absoluten Standard-Browser im System festlegen
    xdg.mimeApps = {
        enable = true;
        defaultApplications = {
            "text/html" = "floorp.desktop";
            "x-scheme-handler/http" = "floorp.desktop";
            "x-scheme-handler/https" = "floorp.desktop";
            "x-scheme-handler/about" = "floorp.desktop";
            "x-scheme-handler/unknown" = "floorp.desktop";
        };
    };

    # Umgebungsvariable BROWSER setzen (wird unter anderem von xdg-open gelesen)
    home.sessionVariables = {
        BROWSER = "floorp";
    };
}
