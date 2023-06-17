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

    Image {
        id: topBarLogo
        scale: Qt.KeepAspectRatio
        height: parent.height
        width: height * 2.84 // To maintain the aspect ratio of the image
        anchors.top: parent.top
        anchors.topMargin: parent.height * 0.1
        source: "../images/Texas-Instruments.png"
    }

    Text {
        id: topBarTitle
        objectName: "topBarTitle"
        text: qsTr("TI Apps Launcher")

        width: parent.width * 0.8
        height: parent.height
        anchors.left: topBarLogo.right
        anchors.top: parent.top
        color: "#FEFFFF"

        font.family: "Ubuntu"
        font.bold: true
        font.pointSize: 35
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }

    Button {
        id: closeButton
        onClicked: Qt.quit()
        height: parent.height * 0.2
        width: height

        anchors.right: parent.right
        anchors.rightMargin: width * 0.5
        anchors.top: parent.top
        anchors.topMargin: height * 0.5

        background: Rectangle {
        Text {
            text: "×"
            font.pointSize: 12
            color: "#FEFFFF"
            anchors.centerIn: parent
            font.bold: true
            }
            color: "#FF0000"
            radius: parent.height
        }
    }

}
