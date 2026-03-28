# FZF-Launcher – Fuzzy-Finder basierter App-Launcher
# Deployt Config-Dateien und Launcher-Scripts für den eigenen FZF-Launcher
{ config, pkgs, ... }:

{
    # FZF Paket installieren – wird vom Launcher-Script gebraucht
    home.packages = with pkgs; [ fzf ];

    # Launcher-Konfiguration nach ~/.config/fzf-launcher/ kopieren
    home.file.".config/fzf-launcher" = {
		source = ./config;
		recursive = true;  # Ganzen Ordner kopieren
	};

	# Launcher-Scripts nach ~/bin/fzf-launcher/ kopieren
	# Diese Scripts werden über Hyprland-Keybinds (Super+S via Quickshell) aufgerufen
	home.file."bin/fzf-launcher" = {
		source = ./scripts;
		recursive = true;  # Ganzen Ordner kopieren
	};
}