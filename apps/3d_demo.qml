import QtQml 2.1
import QtQuick 2.14
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3

Rectangle {
    id: demo3d
    visible: true
    anchors.fill: parent
    color: "#344045"
    Text {
        id: heading
        text: "3D Demo - Imagination"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        font.family: "Helvetica"
        font.pixelSize: demo3d.width * 0.03
        font.bold: true
        color: "#FEFEFE"
    }
    Text {
        id: demo3d_status_msg
        text: demo_3d.status_msg
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: heading.bottom
        anchors.topMargin: parent.height * 0.01
        font.family: "Helvetica"
        font.pixelSize: demo3d.width * 0.01
        color: "#DDDDDD"
    }
    Button {
        id: demo3d_button
        text: demo_3d.button
        anchors.top: demo3d_status_msg.bottom
        anchors.topMargin: parent.height * 0.02
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: demo_3d.launch_or_stop()
        font.pixelSize: demo3d.width * 0.015
        font.family: "Helvetica"
    }
    Text {
        id: demo3d_notice
        textFormat: Text.MarkdownText
        text: "**Note:** The 3D demo launches as a new window without a titlebar. Hence it cannot be repositioned.\n
To stop the 3d demo, you can either\n
1. Press 'Esc' if a keyboard is connected.\n
2. Click outside of the 3D demo on ti-apps-launcher window and click 'Stop'."
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: parent.width * 0.015
        color: "#FF0000"
    }
}
