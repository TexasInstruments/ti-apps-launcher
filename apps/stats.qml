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
    color: "#17252A"
    Rectangle {
        id: backgroundrect
        width: statswindow.width
        height: statswindow.height
        Image {
            id: backgroundimage
            source:"../images/Background.png"
            width: parent.width
            height: parent.height
        }
        Rectangle {
            id: gpubar
            width: parent.width * 0.05
            height: parent.height * 0.7
            color: "#A0A0A0"
            anchors.top: parent.top
            anchors.topMargin: parent.height * 0.1
            anchors.left: parent.left
            anchors.leftMargin: parent.width * 0.05
            Rectangle {
                id: gpubarfill
                color: "steelblue"
                width: parent.width
                height: 0
                anchors.bottom: parent.bottom
            }
            Text {
                id: gpuload
                text: qsTr("0%")
                color: "#F44336"
                font.pixelSize: parent.width * 0.3
                anchors.centerIn: parent
            }
            Timer {
                interval: 1000 // interval in milliseconds
                running: true // start the timer
                repeat: true // repeat the timer
                onTriggered: {
                    gpuload.text = statsbackend.getgpuload()
                    gpubarfill.height = gpuload.text * gpubar.height * 0.01
                    gpuload.text = gpuload.text +"%"
                }
            }
        }
        Rectangle {
            width: parent.width * 0.080
            height: parent.height * 0.8 * 0.2
            anchors.top: gpubar.bottom
            color: "transparent"
            anchors.left: parent.left
            anchors.leftMargin: parent.width * 0.035

            Text {
                //id: gpuload
                text: qsTr("GPU Load")
                color: "#FFFFFF"
                font.pixelSize: parent.width * 0.12
                anchors.centerIn: parent
            }
        }
        Rectangle {
            id: cpubar
            width: parent.width * 0.05
            height: parent.height * 0.7
            color: "#A0A0A0"
            anchors.top: parent.top
            anchors.topMargin: parent.height * 0.1
            anchors.left: gpubar.right
            anchors.leftMargin: parent.width * 0.05
            Rectangle {
                id: cpubarfill
                color: "steelblue"
                width: parent.width
                height: 0
                anchors.bottom: parent.bottom
            }
            Text {
                id: cpuload
                text: qsTr("0")
                color: "#F44336"
                font.pixelSize: parent.width * 0.3
                anchors.centerIn: parent
            }
            Timer {
                interval: 1000 // interval in milliseconds
                running: true // start the timer
                repeat: true // repeat the timer
                onTriggered: {
                    cpuload.text = statsbackend.getcpuload()
                    cpubarfill.height = cpuload.text * cpubar.height * 0.01
                    cpuload.text = cpuload.text + "%"
                }
            }
        }
        Rectangle {
            width: parent.width * 0.080
            height: parent.height * 0.8 * 0.2
            anchors.top: cpubar.bottom
            color: "transparent"
            anchors.left: parent.left
            anchors.leftMargin: parent.width * 0.135

            Text {
                //id: gpuload
                text: qsTr("A72 Load")
                color: "#FFFFFF"
                font.pixelSize: parent.width * 0.12
                anchors.centerIn: parent
            }
        }
    }
}
