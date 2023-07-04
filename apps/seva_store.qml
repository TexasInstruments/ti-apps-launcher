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
    id: runcommand
    visible: true
    anchors.fill: parent

    Text {
        id: cmd_status_msg
        text: seva_store.status_msg
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        font.family: "Helvetica"
        font.pixelSize: 24
        color: "red"
    }
    Button {
        id: cmd_button
        text: seva_store.button
        palette {
            button: "#0000FF"
        }
        anchors.top: cmd_status_msg.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: seva_store.launch_or_stop()
    }
}
