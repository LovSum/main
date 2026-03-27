# Ghostty Terminal-Emulator
# Moderner, GPU-beschleunigter Terminal (Zig-basiert)
# Schnell, minimale Config, native Tabs/Splits
{ config, pkgs, ... }:

{
    # Ghostty installieren
    home.packages = with pkgs; [
        ghostty
    ];

    # Ghostty Config – nur das Nötigste, Defaults sind schon gut
    home.file.".config/ghostty/config".text = ''
        # Font
        font-family = JetBrains Mono
        font-size = 12

        # Theme – Everforest Dark (passend zum restlichen Setup)
        theme = Everforest Dark Hard

        # Fenster
        window-decoration = false
        background-opacity = 0.95

        # Kein Bestätigungsdialog beim Schließen
        confirm-close-surface = false
    '';
}
