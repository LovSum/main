import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

// Haupteinstiegspunkt für Quickshell
ShellRoot {
    // Bar erscheint auf allen Monitoren
    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: bar

            property var modelData
            screen: modelData

            // Bar am oberen Rand, volle Breite
            anchors {
                top: true
                left: true
                right: true
            }

            // Höhe der Bar
            height: 32

            // Hintergrundfarbe (dunkel, passend zum Everforest-Theme)
            color: "#1e1e2e"

            // Bar-Inhalt
            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 12
                anchors.rightMargin: 12
                spacing: 8

                // ── Links: Workspace-Anzeige ──
                RowLayout {
                    spacing: 4

                    Repeater {
                        model: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

                        Rectangle {
                            required property int modelData

                            width: 24
                            height: 24
                            radius: 4

                            // Aktiver Workspace = hervorgehoben
                            color: {
                                if (Hyprland.focusedMonitor?.activeWorkspace?.id === modelData) {
                                    return "#a6e3a1";  // Grün für aktiv
                                }
                                // Prüfen ob Workspace existiert (Fenster darauf)
                                for (let i = 0; i < Hyprland.workspaces.values.length; i++) {
                                    if (Hyprland.workspaces.values[i].id === modelData) {
                                        return "#45475a";  // Grau für belegt
                                    }
                                }
                                return "#313244";  // Dunkel für leer
                            }

                            Text {
                                anchors.centerIn: parent
                                text: parent.modelData === 10 ? "0" : parent.modelData
                                color: {
                                    if (Hyprland.focusedMonitor?.activeWorkspace?.id === parent.modelData) {
                                        return "#1e1e2e";  // Dunkel auf grün
                                    }
                                    return "#cdd6f4";  // Hell auf dunkel
                                }
                                font.pixelSize: 12
                                font.family: "JetBrains Mono"
                                font.bold: true
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    Hyprland.dispatch("workspace " + parent.modelData);
                                }
                            }
                        }
                    }
                }

                // ── Mitte: Aktives Fenster ──
                Item {
                    Layout.fillWidth: true

                    Text {
                        anchors.centerIn: parent
                        text: Hyprland.focusedMonitor?.activeWorkspace?.lastWindow?.title ?? ""
                        color: "#cdd6f4"
                        font.pixelSize: 12
                        font.family: "JetBrains Mono"
                        elide: Text.ElideRight
                        width: Math.min(implicitWidth, parent.width - 20)
                    }
                }

                // ── Rechts: Uhrzeit ──
                Text {
                    id: clock

                    color: "#cdd6f4"
                    font.pixelSize: 13
                    font.family: "JetBrains Mono"
                    font.bold: true

                    // Uhr aktualisieren
                    property var now: new Date()
                    text: now.toLocaleTimeString(Qt.locale("de_DE"), "HH:mm")

                    Timer {
                        interval: 10000  // Alle 10 Sekunden
                        running: true
                        repeat: true
                        onTriggered: clock.now = new Date()
                    }
                }
            }
        }
    }

    // ── FZF-Launcher (Super+S Keybind) ──
    GlobalShortcut {
        name: "launch"
        description: "FZF Launcher öffnen"

        onPressed: {
            Hyprland.dispatch("exec ghostty --title='QML Launcher' -e bash ~/bin/fzf-launcher/launch.sh");
        }
    }
}
