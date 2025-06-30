import QtQuick
import QtQuick.Controls

Item {
    id: thermometer1
    width: 120
    height: 300
    property real minimumValue: -10
    property real maximumValue: 50
    property real value: 20
    property color fillColor: "green"
    property var orientation: "vertical"
    property real opacityValue: 1.0

    Rectangle {
        id: tube
        width: orientation == "vertical" ? 40 : 20
        height: parent.height * 0.9
        anchors.fill: parent
        color: "white"
        border.color: "black"
        border.width: 2
        opacity: opacityValue

        Repeater {
            model: ((maximumValue - minimumValue) / 2) + 1 // tick at every 2 degrees
            delegate: Item {
                id: tickValueItem
                anchors.top: orientation == "vertical" ? undefined : tube.bottom
                anchors.left: orientation == "vertical" ? tube.right : undefined
                width: parent.width
                height: parent.height  // Invisible container for alignment

                property real tickValue: minimumValue + (index * 2)
                property bool isMajorTick: tickValue % 10 === 0  // Major ticks at every 10°C
                property real posY: orientation == "vertical" ? tube.y + tube.height - ((tickValue - minimumValue) / (maximumValue - minimumValue) * tube.height) : tube.y
                property real posX: orientation == "vertical" ? tube.x : tube.x + ((tickValue - minimumValue) / (maximumValue - minimumValue) * tube.width)

                x: posX
                y: posY
                Text {
                    id: valField
                    visible: isMajorTick
                    text: tickValue
                    font.pixelSize: 14
                    color: "black"
                    width: 30
                    anchors.top: tick.bottom
                }
                /* Tick Mark */
                Rectangle {
                    id: tick
                    visible: isMajorTick
                    width: orientation == "vertical" ? 15 : 2
                    height:orientation == "vertical" ? 2 : 15
                    color: "black"
                }
            }
        }
    }

    Rectangle {
        id: mercury
        width: orientation == "vertical" ? tube.width : Math.min(((value - minimumValue) / (maximumValue - minimumValue)) * tube.width, tube.width)
        height: orientation == "vertical" ? Math.min(((value - minimumValue) / (maximumValue - minimumValue)) * tube.height, tube.height) : tube.height
        anchors.left: tube.left
        anchors.leftMargin: orientation == "vertical" ? tube.width * 0.05 : undefined
        anchors.right: orientation == "vertical" ? tube.right : undefined
        anchors.rightMargin: orientation == "vertical" ? tube.width * 0.05 : undefined
        anchors.bottom: tube.bottom
        anchors.bottomMargin: orientation == "vertical" ? undefined : tube.height * 0.05
        anchors.top: orientation == "vertical" ? undefined : tube.top
        anchors.topMargin: orientation == "vertical" ? undefined : tube.height * 0.05
        color: Qt.rgba(thermometer1.value / thermometer1.maximumValue, 1-thermometer1.value / thermometer1.maximumValue , 0 , 1)
        Behavior on height { NumberAnimation { duration: 2000 } }
    }
}
