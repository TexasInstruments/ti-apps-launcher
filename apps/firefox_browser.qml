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
    id: sevastore
    visible: true
    anchors.fill: parent

    Text {
        id: firefox_status_msg
        text: firefox_browser.status_msg
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        font.family: "Helvetica"
        font.pixelSize: 24
        color: "red"
    }
    Button {
        id: firefox_button
        text: firefox_browser.button
        palette {
            button: "#0000FF"
        }
        anchors.top: firefox_status_msg.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: firefox_browser.launch_or_stop()
    }
}
