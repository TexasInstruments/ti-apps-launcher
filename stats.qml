import QtQml 2.1
import QtQuick 2.14
import QtMultimedia 5.1
import QtQuick.Window 2.14
import QtQuick.Controls 2.1
import QtGraphicalEffects 1.12
import Qt.labs.folderlistmodel 2.4

import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtQuick.Layouts 1.3

Rectangle {
    id: statswindow
    visible: true
    width: 1584
    height: 259.2
    Rectangle {
        id: backgroundrect
        width: statswindow.width
        height: statswindow.height
        Image {
            id: backgroundimage
            source:"images/Background.png"
            width: parent.width
            height: parent.height
        }
        Rectangle {
            id: gpubar
            width: parent.width * 0.1
            height: parent.height * 0.8
            color: "#A0A0A0"
            anchors.top: parent.top
            anchors.topMargin: parent.height * 0.1
            anchors.left: parent.left
            anchors.leftMargin: parent.width * 0.05
            Rectangle {
                id: gpubarfill
                color: "#FFFFFF"
                width: parent.width
                height: 0
                anchors.bottom: parent.bottom
            }
            Text {
                id: gpuload
                text: qsTr("0")
                color: "#F44336"
                font.pixelSize: parent.width * 0.20
                anchors.centerIn: parent
            }
            Timer {
                interval: 1000 // interval in milliseconds
                running: true // start the timer
                repeat: true // repeat the timer
                onTriggered: {
                    gpuload.text = backend.getgpuload()
                    gpubarfill.height = gpuload.text * gpubar.height * 0.01
                }
            }
        }
        Rectangle {
            id: cpubar
            width: parent.width * 0.1
            height: parent.height * 0.8
            color: "#A0A0A0"
            anchors.top: parent.top
            anchors.topMargin: parent.height * 0.1
            anchors.left: gpubar.right
            anchors.leftMargin: parent.width * 0.05
            Rectangle {
                id: cpubarfill
                color: "#FFFFFF"
                width: parent.width
                height: 0
                anchors.bottom: parent.bottom
            }
            Text {
                id: cpuload
                text: qsTr("0")
                color: "#F44336"
                font.pixelSize: parent.width * 0.20
                anchors.centerIn: parent
            }
            Timer {
                interval: 1000 // interval in milliseconds
                running: true // start the timer
                repeat: true // repeat the timer
                onTriggered: {
                    cpuload.text = backend.getcpuload()
                    cpubarfill.height = cpuload.text * cpubar.height * 0.01
                }
            }
        }
    }
}