# Nix-Direnv – Automatische Nix-Shell Umgebungen pro Projekt
# Wenn ein Ordner eine flake.nix oder shell.nix hat, wird die Umgebung
# beim Betreten des Ordners automatisch geladen (über direnv + nix-direnv)
{ config, pkgs, ... }: {
    programs.direnv = {
        enable = true;
        
        # Direnv in die Bash-Shell integrieren (Hook wird geladen)
        enableBashIntegration = true;

        # nix-direnv: Verbesserte Nix-Integration für Direnv
        # Cached die Nix-Shell Umgebung, damit sie nicht bei jedem cd neu gebaut wird
        nix-direnv.enable = true;
    };
}