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

    Rectangle {
        id: tube
        width: 40
        height: parent.height * 0.9  // Space at top and bottom
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        color: "white"
        border.color: "black"
        border.width: 2
    }

    Rectangle {
        id: mercury
        width: tube.width
        height: Math.min(((value - minimumValue) / (maximumValue - minimumValue)) * tube.height, tube.height)
//         anchors.horizontalCenter: tube.horizontalCenter
        anchors.left: tube.left
        anchors.right: tube.right
        anchors.bottom: tube.bottom
        color: Qt.rgba(thermometer1.value / thermometer1.maximumValue, 1-thermometer1.value / thermometer1.maximumValue , 0 , 1)
        Behavior on height { NumberAnimation { duration: 500 } }
    }

    /* Tick Marks + Labels */
    Repeater {
        model: ((maximumValue - minimumValue) / 2) + 1 // tick at every 2 degrees
        delegate: Item {
            width: parent.width
            height: parent.height  // Invisible container for alignment

            property real tickValue: minimumValue + (index * 2)
            property bool isMajorTick: tickValue % 10 === 0  // Major ticks at every 10°C
            property real posY: tube.y + tube.height - ((tickValue - minimumValue) / (maximumValue - minimumValue) * tube.height)

            Row {
                y: parent.posY
                Text {
                    visible: isMajorTick
                    text: tickValue
                    font.pixelSize: 14
                    color: "black"
                    horizontalAlignment: Text.AlignRight
                    width: 30
                    x: tube.x - width - 15  // Position to the left of the tube
                    //y: parent.posY - font.pixelSize / 2
                }
                /* Tick Mark */
                Rectangle {
                    id: tick
                    visible: isMajorTick
                    width: 15
                    height: 2
                    color: "black"
                    x: tube.x //- width // Position to the right of the tube
                    //y: parent.posY
                }
            }
        }
    }
}
