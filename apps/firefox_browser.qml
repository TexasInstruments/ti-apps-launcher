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
    id: firefox
    visible: true
    anchors.fill: parent
    color: "#344045"
    Text {
        id: heading
        text: "Firefox Browser"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        font.family: "Helvetica"
        font.pixelSize: firefox.width * 0.03
        font.bold: true
        color: "#FEFEFE"
    }
    Text {
        id: firefox_status_msg
        text: firefox_browser.status_msg
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: heading.bottom
        anchors.topMargin: parent.height * 0.01
        font.family: "Helvetica"
        font.pixelSize: firefox.width * 0.01
        color: "#DDDDDD"
    }
    Button {
        id: firefox_button
        text: firefox_browser.button
        anchors.top: firefox_status_msg.bottom
        anchors.topMargin: parent.height * 0.02
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: firefox_browser.launch_or_stop()
        font.pixelSize: firefox.width * 0.015
        font.family: "Helvetica"
    }
}
