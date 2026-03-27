# System-Konfiguration für den Desktop/Laptop
# Diese Datei definiert die grundlegenden System-Einstellungen (Boot, Netzwerk, User, Pakete)
{ config, pkgs, ... }:

{
  # Hardware-Konfiguration importieren (wird von NixOS automatisch generiert)
  # Enthält: Kernel-Module, Dateisysteme, Partitionen, etc. – spezifisch für diesen Rechner
  # Nach der Installation kopieren: cp /etc/nixos/hardware-configuration.nix hierhin
  imports = [ ./hardware-configuration.nix ];

  # Bootloader: systemd-boot für UEFI-Systeme
  boot.loader.systemd-boot.enable = true;
  # Erlaubt dem Bootloader EFI-Variablen zu ändern (nötig für systemd-boot)
  boot.loader.efi.canTouchEfiVariables = true;

  # Zeitzone auf Mitteleuropäische Zeit setzen
  time.timeZone = "Europe/Berlin";

  # Hostname des Rechners
  networking.hostName = "my-laptop";
  # NetworkManager aktivieren – verwaltet WLAN und Ethernet automatisch
  networking.networkmanager.enable = true;

  # Unfree/proprietäre Pakete erlauben (z.B. für Treiber, bestimmte Software)
  nixpkgs.config.allowUnfree = true;

  # Nix Flakes aktivieren – ohne das funktioniert --flake nicht!
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # ── Audio (PipeWire) ─────────────────────────────────────────
  # Moderner Audio-Stack, ersetzt PulseAudio – ohne das: KEIN SOUND
  services.pipewire = {
    enable = true;
    alsa.enable = true;          # ALSA-Kompatibilität (für ältere Apps)
    alsa.support32Bit = true;    # 32-Bit ALSA Support
    pulse.enable = true;         # PulseAudio-Kompatibilität (für die meisten Apps)
  };

  # ── GPU ──────────────────────────────────────────────────────
  # OpenGL aktivieren – nötig für Ghostty, Zed und generelles Desktop-Rendering
  hardware.graphics.enable = true;

  # ── Polkit ───────────────────────────────────────────────────
  # Erlaubt GUI-Passwortabfragen für Admin-Aktionen (WLAN, USB-Mount, etc.)
  # Der GUI-Agent (hyprpolkitagent) wird in der Hyprland-Config gestartet
  security.polkit.enable = true;

  # ── Schriftarten ─────────────────────────────────────────────
  # System-weit installierte Fonts (für alle Apps, Browser, etc.)
  fonts.packages = with pkgs; [
    jetbrains-mono    # Monospace (Terminal, Editor) – clean, dunkel, technisch
    noto-fonts        # Basis-Font für alle Sprachen (Fallback)
    noto-fonts-emoji  # Emoji-Support 🎉
  ];

  # User-Account Definition
  users.users.user = {
    # Normaler User (kein System-User)
    isNormalUser = true;
    # Zusätzliche Gruppen:
    # - wheel: Erlaubt sudo-Nutzung
    # - networkmanager: Erlaubt Netzwerk-Konfiguration ohne sudo
    # - audio: Direkter Audio-Zugriff (Fallback)
    extraGroups = [ "wheel" "networkmanager" "audio" ];
  };

  # System-weit installierte Pakete (verfügbar für alle User)
  environment.systemPackages = with pkgs; [
    wget  # Dateien aus dem Internet herunterladen
    git   # Versionskontrolle
  ];

  # Wichtig für Desktop-Apps und XDG-Portale (Hyprland):
  environment.pathsToLink = [ "/share/applications" "/share/xdg-desktop-portal" ];

  # NixOS State-Version – NICHT ändern! Definiert die Version bei Erstinstallation
  # Wird für Kompatibilität mit älteren Konfig-Optionen gebraucht
  system.stateVersion = "25.11";

  # Auto-Login: User "user" wird automatisch auf TTY1 eingeloggt (kein Login-Prompt)
  services.getty.autologinUser = "user";
}
