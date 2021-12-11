import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.0
import io.qt.examples.backend 1.0
import Ros 1.0

Item {
    //
    //visible: true
    //width: 320
    //height: 200
    //title: qsTr("C++ Type")

	
	Connections {
		target: Ros
		onShutdown: Qt.quit()
	}

	Subscriber {
		id: battery_sub
		topic: "/robot_status"
	}

    BackEnd{
        id:backend;
        Component.onCompleted: {//call backend signal and slot
            backend.newLocationChanged.connect(backend.logChange);
        }
    }
    Rectangle {
        x: 20
        y: 40
        implicitHeight: 75
        implicitWidth: 490
        color: "lightgray"
    }
    Rectangle {
        x: 20
        y: 135
        implicitHeight: 30
        implicitWidth: 200
        color: "lightgray"
    }
    Rectangle {
        x: 20
        y: 185
        implicitHeight: 30
        implicitWidth: 200
        color: "lightgray"
    }
    Rectangle {
        x: 450
        y: 150
        implicitHeight: 100
        implicitWidth: 150
        color: "lightskyblue"
    }
    Text {
        text: "Valid Locations"
        x: 480
        y: 130
        verticalAlignment: Text.AlignVCenter
    }
    Text {
        text: "Package Zone 1"
        x: 478
        y: 155
        verticalAlignment: Text.AlignVCenter
    }
    Text {
        text: "Package Zone 2"
        x: 478
        y: 180
        verticalAlignment: Text.AlignVCenter
    }
    Text {
        text: "Human Loading Zone"
        x: 462
        y: 205
        verticalAlignment: Text.AlignVCenter
    }
    Rectangle {
        x: 100
        y: 50
        implicitHeight: 20
        implicitWidth: 300
        color: "white"
    }
    Rectangle {
        x: 100
        y: 80
        implicitHeight: 20
        implicitWidth: 300
        color: "white"
    }
    TextInput {
        id: taskInput
        x: 100
        y: 50
        width: 300
        height: 20
        verticalAlignment: TextInput.AlignVCenter
        horizontalAlignment: TextInput.AlignLeft
        //onTextChanged: backend.newLocation = text;
    }
    TextInput {
        id: boxInput
        x: 100
        y: 80
        width: 300
        height: 20
        verticalAlignment: TextInput.AlignVCenter
        horizontalAlignment: TextInput.AlignLeft
        //onTextChanged: backend.newLocation = text;
    }
    Text{
        id:labelBackend;
        text: "Current Task"
        x: 115
        y: 140
    }
    Button {
        id: submitTask
        x: 420
        y: 47
        text: qsTr("GO")

        background: Rectangle {
            implicitHeight: 20
            implicitWidth: 80
            color: "lightblue"
        }
        onPressed: {
            backend.setNewLocation(taskInput.text);
            newLoc = taskInput.text;
        }
    }
    Rectangle {
        x: 490
        y: 300
        implicitHeight: 50
        implicitWidth: 80
        color: "lightgray"
    }
    Rectangle {
        x: 490
        y: 300
        implicitHeight: 50
        implicitWidth: (battery_sub.message ? parseInt(battery_sub.message.battery_percentage,10) : 10)
        color: (parseInt(battery_sub.message.battery_percentage,10) > 10) ? "green" : "red"
    }

    Connections{// connect backend signal
        target: backend;
        onNewLocationChanged:{
            labelBackend.text=backend.newLocation;
        }
    }
	
	Text{
        text: parseInt(battery_sub.message.battery_percentage,10)+"%"
        x: 515
        y: 310
    }
    Text {
        text: "Input:"
        x: 40
        y: 50
        verticalAlignment: Text.AlignVCenter
    }
    Text {
        text: "Task Progress: 25%"
        x: 25
        y: 190
        verticalAlignment: Text.AlignVCenter
    }
    Text {
        text: "Box Input:"
        x: 35
        y: 80
        verticalAlignment: Text.AlignVCenter
    }
    Text {
        text: "Current Task:"
        x: 25
        y: 140
        verticalAlignment: Text.AlignVCenter
    }
    Text {
        text: "Create New Task"
        x: 210
        y: 20
        verticalAlignment: Text.AlignVCenter
    }
	
	Component.onCompleted: {
		Ros.init("qml_home")
	}
}


