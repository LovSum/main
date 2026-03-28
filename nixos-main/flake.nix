# Hauptdefinition des NixOS-Flakes – Einstiegspunkt für das gesamte System
{
	# Kurzbeschreibung dieses Flakes
	description = "My NixOS Flake";

	# Inputs: Externe Abhängigkeiten, die der Flake verwendet
	inputs = {
		# Nixpkgs stable (25.05) – Haupt-Paketquelle
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

		# Nixpkgs unstable – Für Pakete die neuer sein sollen als die stable-Version
		nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

		# Home Manager – Verwaltet die User-Umgebung (Dotfiles, Programme, etc.)
		home-manager = {
			url = "github:nix-community/home-manager/release-25.11";
			# Nutzt dasselbe nixpkgs wie oben, damit keine doppelten Pakete geladen werden
			inputs.nixpkgs.follows = "nixpkgs";
		};


	};

	# Outputs: Was dieser Flake bereitstellt
	outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs : {
		# NixOS System-Konfigurationen – können mit `nixos-rebuild switch --flake .` gebaut werden
		nixosConfigurations = {
			# Konfiguration für den Laptop
			my-laptop = nixpkgs.lib.nixosSystem {
				# Architektur des Systems
				system = "x86_64-linux";
				modules = [
					# System-Konfiguration (Boot, Netzwerk, User, etc.)
					./configurations/my-laptop/configuration.nix
				
					# Home Manager als NixOS-Modul einbinden
					home-manager.nixosModules.home-manager {
						# Globale Pakete verwenden (kein separater Nixpkgs-Channel für Home Manager)
						home-manager.useGlobalPkgs = true;
						# Pakete im User-Profil installieren statt in ~/.nix-profile
						home-manager.useUserPackages = true;
						# Backup-Extension für bestehende Dateien die Home Manager ersetzen will
						home-manager.backupFileExtension = "hm-backup";
						# User-Konfiguration importieren
						home-manager.users.user = import ./user/home.nix;
						# Extra-Argumente für Home Manager Module (z.B. pkgs-unstable)
						home-manager.extraSpecialArgs = {
							# Unstable-Pakete als separates Argument verfügbar machen
							pkgs-unstable = import nixpkgs-unstable {
								system = "x86_64-linux";
								config.allowUnfree = true;
							};

						};
					}
				];
			};
		};
	};
}
