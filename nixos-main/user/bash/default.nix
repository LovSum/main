# Bash Shell Konfiguration
# Setzt Prompt, Aliases, Editor, PATH und aktiviert nützliche Features
{ config, pkgs, ... }:

{
    programs.bash = {
        enable = true;
        # Tab-Completion aktivieren (Befehle und Pfade per Tab vervollständigen)
        enableCompletion = true;

        # Beim Login auf TTY1 automatisch Hyprland starten
        # Wird nur ausgeführt wenn: auf TTY1, Hyprland noch nicht läuft, und kein Display-Server aktiv
        profileExtra = ''
        if [ "$(tty)" = "/dev/tty1" ] && [ -z "$WAYLAND_DISPLAY" ]; then
            exec Hyprland
        fi
        '';

        # Zusätzlicher Inhalt für die ~/.bashrc
        bashrcExtra = ''
        # Standard-Editor auf Neovim setzen
        export EDITOR='nvim'
        # ~/bin zum PATH hinzufügen (für eigene oder Launcher-Skripte)
        export PATH="$HOME/bin:$PATH"

        # Bash-Prompt: "username verzeichnis > " (einfach und übersichtlich)
        PS1="\u \w > "

        # Nützliche Aliases:
        # rebuild: NixOS neu bauen mit aktuellem Flake
        alias rebuild="sudo nixos-rebuild switch --flake . --impure"
        # cleanup: Alte Nix-Generationen löschen und neu bauen (spart Speicherplatz)
        alias cleanup="sudo nix-collect-garbage -d && rebuild"

        # Direnv Hook für Bash aktivieren (lädt .envrc Dateien automatisch beim cd)
        eval "$(direnv hook bash)"
        '';
    };
}