# 🐧 Mein NixOS Setup

NixOS Flake-Konfiguration mit Hyprland Desktop für meinen Laptop (Ryzen 5500U).

## 🚀 Erstinstallation

### 1. NixOS installieren
1. NixOS ISO runterladen: [nixos.org/download](https://nixos.org/download) (Minimal ISO reicht)
2. ISO auf USB-Stick brennen (z.B. mit [Rufus](https://rufus.ie/))
3. Laptop vom USB-Stick booten → NixOS Installer startet (Konsole)
4. Festplatte partitionieren und NixOS installieren
5. Neustarten → Laptop bootet jetzt von der Festplatte (nur Konsole, kein Desktop)

### 2. Config-Dateien rüberkopieren (gleicher USB-Stick)
1. USB-Stick rausziehen
2. Am Windows-PC den Stick formatieren und den `nixos-main/` Ordner draufkopieren
3. USB-Stick wieder in den Laptop stecken
```bash
# Als root einloggen
# USB-Stick mounten
sudo mount /dev/sdb1 /mnt/usb

# Config-Dateien kopieren
cp -r /mnt/usb/nixos-main ~/nixos

# Hardware-Config (von NixOS generiert) in den richtigen Ordner kopieren
cp /etc/nixos/hardware-configuration.nix ~/nixos/configurations/my-desktop/

# USB kann jetzt raus
sudo umount /mnt/usb
```

### 3. System bauen
```bash
cd ~/nixos

# System mit deiner Config bauen und aktivieren
sudo nixos-rebuild switch --flake . --impure

# Passwort für deinen User setzen (einmalig!)
passwd user

# Neustarten – Hyprland startet automatisch!
reboot
```

### Startablauf nach der Installation
```
PC an → systemd-boot → NixOS → Auto-Login als "user"
→ Hyprland startet → Video-Wallpaper, Cursor, Quickshell → Desktop bereit! 🚀
```

## ⌨️ Keybinds (Hyprland)

`$mainMod` = **Super/Windows-Taste**

### Basis
| Keybind | Aktion |
|---|---|
| `Super + Q` | Ghostty Terminal öffnen |
| `Super + C` | Fenster schließen |
| `Super + S` | **App-Suche / Launcher** (Quickshell + FZF) |
| `Super + V` | Fenster schwebend machen |
| `Super + J` | Split-Richtung wechseln |
| `Super + F` | Screenshot (Region) |

### Fenster-Navigation
| Keybind | Aktion |
|---|---|
| `Super + ←↑↓→` | Fokus verschieben |
| `Super + Maus-Links` | Fenster verschieben |
| `Super + Maus-Rechts` / `Super + M` | Fenster resizen |

### Workspaces
| Keybind | Aktion |
|---|---|
| `Super + 1-0` | Workspace 1-10 wechseln |
| `Super + Shift + 1-0` | Fenster zu Workspace verschieben |
| `Super + Mausrad` | Nächster/vorheriger Workspace |

### Media / Hardware
| Keybind | Aktion |
|---|---|
| `Lautstärke +/-` | Lautstärke ändern |
| `Helligkeit +/-` | Bildschirmhelligkeit |
| `Play/Pause/Next/Prev` | Mediensteuerung |

## 📁 Projektstruktur

```
nixos-main/
├── flake.nix                              # Flake-Einstiegspunkt (inkl. Zen Browser Flake)
├── configurations/
│   └── my-desktop/
│       ├── configuration.nix              # System-Config (Boot, User, Netzwerk)
│       └── hardware-configuration.nix     # ⚠️ Nach Installation hierhin kopieren!
└── user/
    ├── home.nix          # Home Manager Hauptconfig
    ├── hypr/             # Hyprland WM Konfiguration
    ├── hyprcursor/       # Rose Pine Cursor-Theme
    ├── mpvpaper/         # Video-Wallpaper (mpvpaper)
    ├── ghostty/          # Ghostty Terminal (GPU-beschleunigt, Zig)
    ├── zed/              # Zed Editor (Haupt-IDE, GPU-beschleunigt, AI)
    ├── neovim/           # Neovim (minimal – Fallback-Editor für Terminal)
    ├── zen/              # Zen Browser (Firefox-basiert, externer Flake)
    ├── fzf-launcher/     # FZF App-Launcher (Quickshell Backend)
    ├── git/              # Git + Credential Manager
    ├── bash/             # Bash Shell Config + Hyprland Auto-Start
    └── nix-direnv/       # Nix + Direnv
```

## 🔧 Nützliche Befehle

| Befehl | Aktion |
|---|---|
| `rebuild` | System neu bauen (`sudo nixos-rebuild switch --flake . --impure`) |
| `cleanup` | Alte Generationen löschen + rebuild (Speicher frei machen) |
| `nvim` | Neovim öffnen (minimaler Editor für Terminal-Edits) |
| `zed` | Zed Editor öffnen (Haupt-IDE) |
| `zen` | Zen Browser starten |

## 🔄 Etwas ändern?
1. Config-Datei bearbeiten (z.B. mit `nvim` im Terminal oder `zed` für Projekte)
2. `rebuild` ausführen
3. Fertig! Bei Problemen: Beim Booten eine ältere Generation auswählen
