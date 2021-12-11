import QtQuick 2.0
import QtQuick.Window 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.12
import io.qt.examples.backend 1.0
import Ros 1.0

ApplicationWindow {
    id: root
    width: 640
    height: 480
    visible: true
    title: qsTr("Learning Factory Dashboard ")

    BackEnd {
        id: backend
    }

	Connections {
		target: Ros
		onShutdown: Qt.quit()
	}

	Subscriber {
		id: status_sub
		topic: "/robot_state"
	}

    // Bottom toolbar
    footer: ToolBar {
        RowLayout {
            anchors.fill: parent
            Label {
                id: status
                //text: "  MiR100 Status:   " + "Not Busy"
				function status_phrase(code) {
					switch(code) {
					case 1:
						return "Starting";
					case 2:
						return "Shutting Down";
					case 3:
						return "Ready";
					case 4:
						return "Paused";
					case 5:
						return "Mission Active";
					case 6:
						return "Aborted";
					case 7:
						return "Mission Completed";
					case 8:
						return "Robot Charging";
					case 9:
						return "Robot Docking";
					case 10:
						return "E-Stop Active";
					case 11:
						return "Manual Controls Engaged";
					case 12:
						return "ERROR";
					default:
						return "Not Busy";
					}
				}
				text: "  MiR100 Status:   " + status_phrase(status_sub.message.robotState)
				horizontalAlignment: Qt.AlignLeft
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
            }

            ToolButton {
                id: start
                text: qsTr("Start Task")

                background: Rectangle {
                    implicitHeight: 50
                    implicitWidth: 100
                    color: "darkseagreen"
                }
            }

            ToolButton {
                id: stop
                text: qsTr("Stop Task")

                background: Rectangle {
                    implicitHeight: 50
                    implicitWidth: 100
                    color: "tomato"
                }
            }
        }
    }

    // Top tabbar with 4 pages
    menuBar: TabBar {
        id: bar

        TabButton {
            text: qsTr("Home")
        }
        TabButton {
            text: qsTr("History")
        }
        TabButton {
            text: qsTr("Inventory")
        }
        TabButton {
            text: qsTr("Map")
        }
    }
    property string newLoc;
    // Main stack layout for the pages
    StackLayout {
        width: parent.width
        currentIndex: bar.currentIndex

        Item {
            id: homeTab
            HomePage {

            }
        }

        Item {
            id: histTab
            HistoryPage{

            }
        }

        Item {
            id: invenTab
            InventoryPage {

            }
        }

        Item {
            id: mapTab
            MapPage {

            }
        }
    }
}
