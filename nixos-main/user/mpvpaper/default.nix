# mpvpaper – Video-Wallpaper für Hyprland
# Spielt ein Video als animiertes Hintergrundbild auf allen Monitoren ab (endlos geloopt)
# mpvpaper nutzt mpv als Backend und unterstützt alle gängigen Videoformate
{ config, pkgs, ... }:

{
    # mpvpaper Paket installieren – Video-Wallpaper Player für Wayland/Hyprland
    home.packages = with pkgs; [
        mpvpaper
    ];

    # Video-Dateien nach ~/wallpapers/ deployen
    # Neue Videos einfach in diesen Ordner im Repo legen, sie werden automatisch deployt
    home.file."wallpapers/smoking-wp.mp4" = {
        source = ./smoking-wp.mp4;  # Video-Datei aus dem Repo
    };
}
