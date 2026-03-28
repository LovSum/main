import Quickshell
import Quickshell.Io
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

                // ── Rechts: Hardware & Uhrzeit ──
                RowLayout {
                    spacing: 16

                    // WLAN 
                    Text {
                        id: wifiText
                        color: "#cdd6f4"
                        font.pixelSize: 13
                        font.family: "JetBrains Mono"
                        text: "📶 ..."

                        Process {
                            id: wifiProc
                            command: ["sh", "-c", "nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2 | head -n 1"]
                            running: true
                            stdout: StdioCollector {
                                id: wifiOut
                                onStreamFinished: wifiText.text = "📶 " + (wifiOut.text.trim() === "" ? "Offline" : wifiOut.text.trim())
                            }
                        }
                        Timer {
                            interval: 5000; running: true; repeat: true
                            onTriggered: { wifiProc.running = false; wifiProc.running = true }
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: Hyprland.dispatch("exec ghostty --title='WLAN Menu' -e nmtui")
                        }
                    }

                    // Audio
                    Text {
                        id: volText
                        color: "#cdd6f4"
                        font.pixelSize: 13
                        font.family: "JetBrains Mono"
                        text: "🔊 ..."

                        Process {
                            id: volProc
                            command: ["sh", "-c", "wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100) \"%\"}'"]
                            running: true
                            stdout: StdioCollector {
                                id: volOut
                                onStreamFinished: volText.text = "🔊 " + volOut.text.trim()
                            }
                        }
                        Timer {
                            interval: 2000; running: true; repeat: true
                            onTriggered: { volProc.running = false; volProc.running = true }
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: Hyprland.dispatch("exec pavucontrol")
                        }
                    }

                    // Battery
                    Text {
                        id: batText
                        color: "#cdd6f4"
                        font.pixelSize: 13
                        font.family: "JetBrains Mono"
                        text: "🔋 ..."

                        Process {
                            id: batProc
                            command: ["sh", "-c", "cat /sys/class/power_supply/BAT*/capacity | head -n 1"]
                            running: true
                            stdout: StdioCollector {
                                id: batOut
                                onStreamFinished: batText.text = "🔋 " + batOut.text.trim() + "%"
                            }
                        }
                        Timer {
                            interval: 30000; running: true; repeat: true
                            onTriggered: { batProc.running = false; batProc.running = true }
                        }
                    }

                    // Uhrzeit
                    Text {
                        id: clock
                        color: "#cdd6f4"
                        font.pixelSize: 13
                        font.family: "JetBrains Mono"
                        font.bold: true

                        property var now: new Date()
                        text: now.toLocaleTimeString(Qt.locale("de_DE"), "HH:mm")

                        Timer {
                            interval: 10000
                            running: true
                            repeat: true
                            onTriggered: clock.now = new Date()
                        }
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
