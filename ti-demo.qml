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
Window {
    visible: true
    visibility: "FullScreen"
    title: qsTr("TI Demo")

    Rectangle {
        id: appBackground
        color: "transparent"
        width: parent.width
        height: parent.height

        Loader {
            id: topBar
            anchors.fill: parent
            source: "qml/auto_cluster.qml"
        }
    }
}
