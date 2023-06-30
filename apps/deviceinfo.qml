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
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        Text {
            id: platform
            anchors.left: parent.left
            anchors.top: parent.top
            font.pointSize: 13
            text: "Platform: " + deviceinfo.getplatform()
            color: "#FEFFFF"
        }
        
        Text {
            id: ipAddr
            anchors.left: parent.left
            anchors.top: platform.bottom
            font.pointSize: 13
            text: backend.ip_addr
            color: "#FEFFFF"
        }
        Text {
            id: info1
            anchors.left: parent.left
            anchors.top: ipAddr.bottom
            font.pointSize: 13
            text: "<font color=\"#FEFFFF\"> Support: </font><font color=\"#FF0000\">https://e2e.ti.com/</font>"
        }
    }
}


