# Neovim – Minimaler Terminal-Editor
# Nur als Fallback für schnelle Edits im Terminal gedacht
# Haupteditor ist Zed – Neovim wird nur für Config-Änderungen via SSH/Terminal genutzt
{ config, pkgs, ... }:

{
    # Neovim über Home Manager aktivieren
    programs.neovim = {
        enable = true;
        # Neovim als Standard-Editor setzen (EDITOR, VISUAL)
        defaultEditor = true;
        # Vi/Vim Befehle auf Neovim umleiten
        viAlias = true;
        vimAlias = true;
    };

    # Keine LazyVim-Config, keine Plugins – Neovim pur
    # Reicht völlig für schnelle Config-Edits im Terminal
}
