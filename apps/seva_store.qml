import QtQuick 2.14
import QtQuick.Controls 2.1

Rectangle {
    id: seva
    visible: true
    anchors.fill: parent
    color: "#344045"
    Text {
        id: heading
        text: "Seva Store"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        font.family: "Helvetica"
        font.pixelSize: seva.width * 0.03
        font.bold: true
        color: "#FEFEFE"
    }
    Text {
        id: seva_status_msg
        text: seva_store.status_msg
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: heading.bottom
        anchors.topMargin: parent.height * 0.01
        font.family: "Helvetica"
        font.pixelSize: seva.width * 0.01
        color: "#DDDDDD"
    }
    Button {
        id: cmd_button
        text: seva_store.button
        anchors.top: seva_status_msg.bottom
        anchors.topMargin: parent.height * 0.02
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: seva_store.launch_or_stop()
        font.pixelSize: seva.width * 0.015
        font.family: "Helvetica"
    }
}
