# Git Konfiguration
# Setzt Username, Email, und den Credential Manager für GitHub-Authentifizierung
{ config, pkgs, ... }:

{
    # Git über Home Manager konfigurieren
    programs.git = {
        enable = true;
        # Git Username und Email für Commits
        userName = "LovSum";
        userEmail = "LovSum@users.noreply.github.com";

        # Credential-Verwaltung: Speichert Login-Daten damit man nicht jedes Mal neu einloggen muss
        extraConfig.credential = {
            # Git Credential Manager als Helper nutzen
            helper = "manager";
            # Credentials als Klartext speichern (einfach, aber weniger sicher)
            credentialStore = "plaintext";

            # GitHub-spezifischer Username für automatische Zuordnung
            "https://github.com".username = "LovSum";
        };
    };

    # Git Credential Manager Paket installieren (wird oben als Helper verwendet)
    home.packages = with pkgs; [
        git-credential-manager
    ];
}
