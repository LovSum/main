# Hyprland Window Manager Konfiguration
# Aktiviert Hyprland und bindet eine externe user.conf ein
{ config, pkgs, ... }:

{
	# Wir kopieren die Datei fest in den Nix-Store, damit das System zu 100% Plug & Play ist.
	# (Egal von wo oder als welcher Nutzer der Rebuild gestartet wird, der Pfad stimmt immer!)
	home.file.".config/hypr/user.conf".source = ./config/user.conf;

	# Hyprland Window Manager aktivieren und konfigurieren
	wayland.windowManager.hyprland = {
        enable = true;
        
		# Hyprland-Plugins
		pluginixns = [
			# Scrolling-Layout Plugin – Alternative zum Standard Dwindle/Master Layout
			pkgs.hyprlandPlugins.hyprscrolling
		];

		# Hyprland Settings – hier wird die externe user.conf geladen
		settings = {
			# Lädt die vollständige Konfiguration aus der separaten user.conf Datei
			source = "~/.config/hypr/user.conf";
		};
	};

	# Electron/Chrome Apps sollen nativ Wayland nutzen (kein XWayland)
 	home.sessionVariables.NIXOS_OZONE_WL = "1";
}