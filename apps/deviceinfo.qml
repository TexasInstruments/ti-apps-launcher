import QtQml 2.1
import QtQuick 2.14
import QtMultimedia 5.1
import QtQuick.Window 2.14
import QtQuick.Controls 2.1
import QtGraphicalEffects 1.12
import Qt.labs.folderlistmodel 2.4

Rectangle {
    width: parent.width
    height: parent.height
    color: "#17252A"
    Rectangle {
        width: parent.width * 0.9
        height: parent.height
        color: "#344045"

        border.color: "#DEF2F1"
        border.width: 3
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        Text {
            id: platform
            anchors.left: parent.left
            anchors.leftMargin: parent.width * 0.05
            anchors.top: parent.top
            anchors.topMargin: parent.height * 0.05
            font.pixelSize: parent.width * 0.06
            text: "Platform: " + deviceinfo.getplatform()
            color: "#FEFFFF"
        }
        
        Text {
            id: ipAddr
            anchors.left: parent.left
            anchors.leftMargin: parent.width * 0.05
            anchors.top: platform.bottom
            anchors.topMargin: parent.height * 0.05
            font.pixelSize: parent.width * 0.06
            text: deviceinfo.ip_addr
            color: "#FEFFFF"
        }
        Text {
            id: info1
            anchors.left: parent.left
            anchors.leftMargin: parent.width * 0.05
            anchors.top: ipAddr.bottom
            anchors.topMargin: parent.height * 0.05
            font.pixelSize: parent.width * 0.06
            text: "<font color=\"#FEFFFF\"> Support: <br></font><font color=\"#FF0000\">https://e2e.ti.com/</font>"
        }
    }
}

