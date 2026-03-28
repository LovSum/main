# Quickshell – QtQuick-basierte Desktop-Shell für Hyprland
# Stellt die Status-Leiste (Bar), Widgets und den FZF-Launcher bereit
# Konfiguration liegt in ~/.config/quickshell/shell.qml
{ config, pkgs, ... }:

{
    # Quickshell Paket installieren
    home.packages = with pkgs; [
        quickshell
    ];

    # Quickshell Config nach ~/.config/quickshell/ deployen
    # Die shell.qml definiert das Aussehen und Verhalten der Bar
    home.file.".config/quickshell" = {
        source = ./config;
        recursive = true;
    };
}
