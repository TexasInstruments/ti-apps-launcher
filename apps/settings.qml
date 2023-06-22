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
    color: "#17252A"
    Rectangle {
        id: proxyForm

        width: parent.width * 0.9
        height: parent.height * 0.9
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        color: "#344045"

        Column {
            anchors.centerIn: parent

            TextField {
                id: https_proxy
            }
            TextField {
                id: no_proxy
            }
            Button {
                id: set_proxy_button
                text: "Set Proxy"
                onClicked: settings.set_proxy(https_proxy.text, no_proxy.text)
            }
        }
    }
}

