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
    width: parent.width
    height: parent.height
    color: "#344045"
    Rectangle {
        id: proxyForm
        width: parent.width * 0.3
        height: parent.height * 0.5
        anchors.centerIn: parent
        color: "#344045"

        ColumnLayout {
            anchors.fill: proxyForm
            anchors.centerIn: proxyForm
            spacing: 10

            Rectangle {
                color: "transparent"
                Layout.alignment: Qt.AlignCenter
                Layout.preferredWidth: parent.width * 0.9
                Layout.preferredHeight: parent.height * 0.2

                Text{
                    id: https_proxy_head
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width * 0.05
                    text: "HTTPS Proxy:"
                    font.pixelSize: proxyForm.width * 0.04
                    font.bold: true
                    font.family: "Helvetica"
                    color: "#FEFEFE"
                }
                TextField {
                    id: https_proxy
                    anchors.top: https_proxy_head.bottom
                    anchors.topMargin: parent.height * 0.05
                    anchors.left: https_proxy_head.left
                    height: parent.height * 0.8
                    width: parent.width * 0.9
                    font.pixelSize: proxyForm.width * 0.04
                }
            }
            Rectangle {
                color: "transparent"
                Layout.alignment: Qt.AlignCenter
                Layout.preferredWidth: parent.width * 0.9
                Layout.preferredHeight: parent.height * 0.2

                Text {
                    id: no_proxy_head
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width * 0.05
                    text: "NO Proxy:"
                    font.pixelSize: proxyForm.width * 0.04
                    font.bold: true
                    font.family: "Helvetica"
                    color: "#FEFEFE"
                }
                TextField {
                    id: no_proxy
                    anchors.top: no_proxy_head.bottom
                    anchors.topMargin: parent.height * 0.05
                    anchors.left: no_proxy_head.left
                    height: parent.height * 0.8
                    width: parent.width * 0.9
                    font.pixelSize: proxyForm.width * 0.04
                }
            }
            Button {
                id: set_proxy_button
                text: "Set Proxy"
                Layout.alignment: Qt.AlignCenter
                Layout.preferredWidth: parent.width * 0.5
                Layout.preferredHeight: parent.height * 0.15
                font.pixelSize: proxyForm.width * 0.04
                font.family: "Helvetica"
                onClicked: {
                    proxy_status.text = "Setting new proxy configuration .."
                    settings.set_proxy(https_proxy.text, no_proxy.text)
                    proxy_status.text = "Proxy set successfully!"
                    proxy_status.color = "#00FF00"
                }
            }
            Text {
                id: proxy_status
                Layout.alignment: Qt.AlignCenter
                text: "Click 'Set Proxy' to set new proxy configuration."
                font.pixelSize: proxyForm.width * 0.03
                font.family: "Helvetica"
                color: "#FF0000"
            }
        }
    }
}

