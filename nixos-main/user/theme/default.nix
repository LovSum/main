# Systemweiter Dark Mode und GTK/Qt Theming 
{ config, pkgs, ... }:

{
    # GTK (GNOME) Programme: Erzwinge Adwaita-dark
    gtk = {
        enable = true;
        theme = {
            name = "Adwaita-dark";
            package = pkgs.gnome-themes-extra;
        };
        iconTheme = {
            name = "Adwaita";
            package = pkgs.adwaita-icon-theme;
        };
    };

    # Qt (KDE) Programme: Simuliere GTK Aussehen
    qt = {
        enable = true;
        platformTheme.name = "gtk";
        style.name = "adwaita-dark";
    };

    # dconf (Freedesktop Standard für Settings)
    # Teilt Programmen wie Zed, Floorp und Electron mit, dass das System dunkel ist
    dconf.settings = {
        "org/gnome/desktop/interface" = {
            color-scheme = "prefer-dark";
        };
    };
    
    # Cursor Theme (Sicherstellt, dass der Cursor auf Wayland überall gleich groß/dunkel ist)
    home.pointerCursor = {
        name = "Adwaita";
        package = pkgs.adwaita-icon-theme;
        size = 24;
        gtk.enable = true;
        x11.enable = true;
    };
}
