# Zed Editor – Moderner, GPU-beschleunigter Code-Editor
# Schnellster GUI-Editor (Rust/GPUI), mit AI-Integration und Vim-Mode
# Haupteditor für Projekte, Jupyter Notebooks, etc.
{ config, pkgs, ... }:

{
    # Zed installieren
    home.packages = with pkgs; [
        zed-editor
    ];

    # Zed Settings
    home.file.".config/zed/settings.json".text = builtins.toJSON {
        # Theme – Festes dunkles Design
        theme = "One Dark";

        # Font – passend zum Terminal
        buffer_font_family = "JetBrains Mono";
        buffer_font_size = 14;
        ui_font_family = "JetBrains Mono";
        ui_font_size = 14;

        # Vim-Mode (optional – auskommentieren wenn nicht gewünscht)
        vim_mode = false;

        # Terminal im Editor
        terminal = {
            font_family = "JetBrains Mono";
            font_size = 12;
        };

        # Telemetrie deaktivieren
        telemetry = {
            diagnostics = false;
            metrics = false;
        };

        # Auto-Save
        autosave = "on_focus_change";

        # Nix-Formatter (nutzt nixfmt wenn installiert)
        languages = {
            Nix = {
                formatter = {
                    external = {
                        command = "nixfmt";
                    };
                };
            };
        };
    };
}
