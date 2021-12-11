import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.0
import io.qt.examples.backend 1.0

ApplicationWindow {
	Item {
		BackEnd{
			id:backend;
			Component.onCompleted: {//call backend signal and slot
				backend.newLocationChanged.connect(backend.logChange);
			}

		}
		Text{
			id:label;
			text: "Current Destination"
			x: 50
			y: 20
		}
		Text{
			id:label2;
			text: "Current Destination"
			x: 50
			y: 70
		}
		Text{
			id:label3;
			text: "Current Destination"
			x: 50
			y: 120
		}
		Text{
			id:label4;
			text: "Current Destination"
			x: 50
			y: 170
		}
		Text{
			id:label5;
			text: "Current Destination"
			x: 50
			y: 220
		}
		Text{
			id:label6;
			text: "Current Destination"
			x: 50
			y: 270
		}
		Text{
			id:label7;
			text: "Current Destination"
			x: 50
			y: 320
		}
		Text{
			id:label8;
			text: "Current Destination"
			x: 50
			y: 370
		}
		Button {
			id: submitTask
			x: 420
			y: 47
			text: qsTr("Update")

			background: Rectangle {
				implicitHeight: 20
				implicitWidth: 80
				color: "lightblue"
			}
			onPressed: {
				//backend.setNewLocation();
				label8.text = label7.text;
				label7.text = label6.text;
				label6.text = label5.text;
				label5.text = label4.text;
				label4.text = label3.text;
				label3.text = label2.text;
				label2.text = label.text;
				label.text = newLoc;

				//backend.setNewLocation();
			}
		}
		Connections{// connect backend signal
			target: backend;
			onNewLocationChanged:{
				label.text=backend.newLocation;
			}
		}
	}
}
