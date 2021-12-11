import QtQuick 2.0
import QtQuick.Shapes 1.12
//640 480
Item {
    Rectangle {
        x: 40
        y: 40
        implicitHeight: 320
        implicitWidth: 200
        color: "lightgray"
    }
    Rectangle {
        x: 270
        y: 210
        implicitHeight: 150
        implicitWidth: 340
        color: "lightgray"
    }
    Rectangle {
        x: 270
        y: 40
        implicitHeight: 140
        implicitWidth: 340
        color: "lightgray"
    }
    Rectangle {
        x: 50
        y: 50
        implicitHeight: 67.5
        implicitWidth: 85
        color: "white"
    }
    Rectangle {
        x: 50
        y: 127.5
        implicitHeight: 67.5
        implicitWidth: 85
        color: "white"
    }
    Rectangle {
        x: 50
        y: 205
        implicitHeight: 67.5
        implicitWidth: 85
        color: "white"
    }
    Rectangle {
        x: 50
        y: 282.5
        implicitHeight: 67.5
        implicitWidth: 85
        color: "white"
    }
    Rectangle {
        x: 145
        y: 50
        implicitHeight: 67.5
        implicitWidth: 85
        color: "white"
    }
    Rectangle {
        x: 145
        y: 127.5
        implicitHeight: 67.5
        implicitWidth: 85
        color: "white"
    }
    Rectangle {
        x: 145
        y: 205
        implicitHeight: 67.5
        implicitWidth: 85
        color: "white"
    }
    Rectangle {
        x: 145
        y: 282.5
        implicitHeight: 67.5
        implicitWidth: 85
        color: "white"
    }
    Text {
        text: "Package Location 1"
        x: 380
        y: 184
    }
    Text {
        text: "Package Location 2"
        x: 380
        y: 21
    }
    Text {
        text: "MiR100 Packages"
        x: 90
        y: 21
    }
    /*
    Shape {
        width: 200
        height: 150
        ShapePath {
            fillColor: "red"
            startX: 200; startY: 200
            PathLine { x: 180; y: 130 }
            PathLine { x: 20; y: 130 }
            PathLine { x: 20; y: 20 }
        }
    }
    */
    Rectangle {
        x: 70
        y: 60
        width: 50
        height: 50
        color: "red"
        radius: width*0.5
        /*
        Text {
             color: "red"
             text: "Boom"
        }
        */
    }
}
