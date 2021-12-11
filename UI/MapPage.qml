import QtQuick 2.0
import QtQuick.Controls 2.2

//640 480
Item {
	Rectangle {
		x: 245
		y: 20
		implicitHeight: 250
		implicitWidth: 150
		color: "lightgray"
	}
	Rectangle {
		x: 295
		y: 120
		implicitHeight: 50
		implicitWidth: 50
		color: "blue"
	}
	Rectangle {
		x: 40
		y: 300
		implicitHeight: 70
		implicitWidth: 140
		color: "red"
	}
	Text {
		text: "Package Zone 1"
		x: 270
		y: 80
	}
	Text {
		text: "Package Zone 2"
		x: 270
		y: 200
	}
	Text {
		text: "Human Loading Zone"
		x: 50
		y: 320
	}
}
