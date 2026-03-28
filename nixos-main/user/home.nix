# Home Manager Hauptkonfiguration
# Verwaltet die User-Umgebung: Programme, Dotfiles, und weitere Module
{ config, pkgs, ... }:

{
  # Username und Home-Verzeichnis für Home Manager
  home.username = "user";
  home.homeDirectory = "/home/user";

  # Modulare Imports – jedes Modul konfiguriert einen Bereich der User-Umgebung
  imports = [
    ./hypr          # Hyprland Window Manager Konfiguration
    ./hyprcursor    # Custom Cursor-Theme (Rose Pine)
    ./mpvpaper      # Video-Wallpaper (mpvpaper, ersetzt hyprpaper)
    ./ghostty       # Ghostty Terminal-Emulator (GPU-beschleunigt, Zig)
    ./fzf-launcher  # FZF-basierter App-Launcher
    ./git           # Git Konfiguration & Credential Manager
    ./bash          # Bash Shell Konfiguration
    ./nix-direnv    # Direnv + Nix Integration für projektbasierte Shells
    ./neovim        # Neovim (minimal – Fallback-Editor für Terminal)
    ./zed           # Zed Editor (Haupt-IDE, GPU-beschleunigt, AI-Integration)
    ./floorp        # Floorp Browser (Firefox-basiert)
    ./quickshell    # Quickshell Status-Bar (QtQuick, Hyprland-Integration)
  ];

  # User-spezifische Pakete (nur für diesen User installiert)
  home.packages = with pkgs; [
    jetbrains-mono  # Monospace-Font (für Ghostty + Zed)
    brightnessctl   # Bildschirmhelligkeit steuern (Laptop)
    fastfetch       # System-Infos im stylischen Look
    pavucontrol     # Audio / Volume Control (Mixer)
    hyprshot        # Screenshot-Tool für Hyprland
    playerctl       # Media-Player Steuerung (für Hyprland Media-Keys)
    unzip           # ZIP-Archive entpacken
    btop            # System-Monitor TUI
    circumflex      # Hacker News TUI Client
    superfile       # Moderner Terminal-Dateimanager
    nixfmt-rfc-style # Nix Formatter (für Zed Nix-Formatting)
  ];

  # Home Manager State-Version – NICHT ändern! Wie system.stateVersion
  home.stateVersion = "25.11";
}
