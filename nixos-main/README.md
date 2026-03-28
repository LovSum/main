# 🐧 Mein NixOS Laptop Setup

Eine moderne, Flake-basierte NixOS Konfiguration mit Hyprland. Fokus auf GPU-beschleunigte, schnelle Tools und ein sauberes, dunkles Design (Everforest/Catppuccin-Vibes).

---

## 🚀 Die Programme (Was benutze ich?)

Das System ist minimalistisch aufgebaut. Statt fetter Desktop-Umgebungen (wie KDE oder GNOME) kommen spezialisierte, schnelle Einzelprogramme zum Einsatz:

### Kern-System
- **Window Manager:** [Hyprland](https://hyprland.org/) (Wayland, Tiling, Scrolling-Layout)
- **Status-Bar:** [Quickshell](https://quickshell.outfoxxed.me/) (QtQuick-basiert, oben am Bildschirm, zeigt Workspaces & Uhr)
- **App-Launcher:** Eigenbau mit `fzf` im Terminal (gestartet über Quickshell Keybind)
- **Wallpaper:** [mpvpaper](https://github.com/GhostNaN/mpvpaper) (Video-Wallpaper im Hintergrund)

### Apps
- **Terminal:** [Ghostty](https://mitchellh.com/ghostty) (GPU-beschleunigt, extrem schnell, nutzt JetBrains Mono)
- **Browser:** [Floorp](https://floorp.app/) (Firefox-basiert, extrem anpassbar, vertikale Tabs)
- **Code Editor (GUI):** [Zed](https://zed.dev/) (Rust/GPU, extrem schnell, Befehl: `zeditor`)
- **Code Editor (Terminal):** Neovim (`nvim`, minimal konfiguriert als Fallback)

### Terminal-Tools (TUI)
- **Dateimanager:** `superfile` (oder `spf`)
- **System-Monitor:** `btop`
- **System-Info:** `fastfetch`
- **Hacker News:** `circumflex`

---

## ⌨️ Die wichtigsten Tastenkürzel (Hyprland)

Die `Super`-Taste (Windows-Taste) ist dein bester Freund.

| Kombination | Was passiert? |
|-------------|---------------|
| `Super + Q` | **Terminal öffnen** (Ghostty) |
| `Super + S` | **App-Launcher öffnen** (Sucht in gui-programs.txt) |
| `Super + C` | **Fenster schließen** (Kill) |
| `Super + V` | **Floating umschalten** (Fenster schweben lassen) |
| `Super + F` | **Screenshot** (Bereich auswählen, landet in der Zwischenablage) |
| `Super + Maus (Links)` | **Fenster verschieben** (Gedrückt halten) |
| `Super + Maus (Rechts)`| **Fenster Größe ändern** (Gedrückt halten) |
| `Super + 1 ... 0` | Zu **Workspace** 1 bis 10 wechseln |
| `Super + Shift + 1 ... 0` | Aktuelles Fenster auf Workspace verschieben |
| `Super + Pfeiltasten` | Fokus zwischen Fenstern wechseln |

*Hinweis: Drei-Finger-Wischgeste nach links/rechts auf dem Touchpad wechselt ebenfalls die Workspaces!*

---

## 🔄 Wie aktualisiere oder ändere ich das System?

Da du NixOS nutzt, ist dein System **deklarativ**. Du installierst keine Programme mit `apt install` oder über einen App Store. Stattdessen schreibst du alles in diese Config und baust das System neu.

### 1. Etwas hinzufügen oder ändern
- Öffne den Ordner `~/nixos-config/nixos-main/` im `zeditor` oder `nvim`.
- Um ein Programm für dich (den User) zu installieren, trage es in `user/home.nix` bei `home.packages` ein.
- Speichere die Datei.

### 2. Das System neu bauen (Rebuild)
Führe nach jeder Änderung diesen Befehl im Terminal aus:
```bash
cd ~/nixos-config/nixos-main
sudo nixos-rebuild switch --flake .#my-laptop
```
*Tipp: Du kannst dir in deiner `user/bash/default.nix` einen Alias wie `rebuild` dafür anlegen!*

### 3. Was tun, wenn etwas kaputt geht?
NixOS speichert jede Version deines Systems. Wenn nach einem Rebuild gar nichts mehr geht:
- Starte den Laptop neu.
- Halte im Boot-Menü die **Leertaste** gedrückt.
- Wähle einfach eine ältere "Generation" aus der Liste aus und boote sie. Alles ist sofort wieder wie vorher!

---

## 📁 Ordner-Struktur (Wo finde ich was?)

Alle Einstellungen liegen in Modulen unterteilt, damit es übersichtlich bleibt:

```text
nixos-main/
├── flake.nix                          # Der Startpunkt. Zieht Pakete (Inputs) aus dem Internet.
├── configurations/
│   └── my-laptop/
│       ├── configuration.nix          # System-Basis (Netzwerk, Audio, GPU, User-Passwort)
│       └── hardware-configuration.nix # Hardware-Infos vom Laptop (wird lokal generiert)
└── user/
    ├── home.nix                       # Sammelt alle User-Programme (Home Manager)
    ├── hypr/                          # Window Manager Config (Tastenkürzel, Gesten)
    ├── quickshell/                    # Status-Bar Config (shell.qml)
    ├── fzf-launcher/                  # Das Super+S Suchmenü
    ├── ghostty/, zed/, zen/           # Einzelne Programm-Einstellungen
    └── ...
```
