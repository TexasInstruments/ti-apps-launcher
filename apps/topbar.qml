import QtQml 2.1
import QtQuick 2.14
import QtMultimedia 5.1
import QtQuick.Window 2.14
import QtQuick.Controls 2.1
import QtGraphicalEffects 1.12
import Qt.labs.folderlistmodel 2.4
import QtQuick.Layouts 1.15

Rectangle {
    width: parent.width
    height: parent.height
    color: "#17252A"

    Image {
        id: topBarLogo
        scale: Qt.KeepAspectRatio
        height: parent.height
        width: height * 2.84 // To maintain the aspect ratio of the image
        anchors.top: parent.top
        anchors.topMargin: parent.height * 0.1
        source: "file:///opt/ti-apps-launcher/assets/Texas-Instruments.png"
    }

    Text {
        id: topBarTitle
        objectName: "topBarTitle"
        text: qsTr("TI Apps Launcher")

        width: parent.width * 0.8
        height: parent.height
        anchors.left: topBarLogo.right
        anchors.top: parent.top
        color: "#FEFFFF"

        font.family: "Helvetica"
        font.bold: true
        font.pixelSize: parent.width * 0.03
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }

    Image {
        id: closeButton
        height: parent.height * 0.3
        width: height
        source: "file:///opt/ti-apps-launcher/assets/close.png"
        fillMode: Image.PreserveAspectFit
        anchors.right: parent.right
        anchors.rightMargin: width * 0.5
        anchors.top: parent.top
        anchors.topMargin: height * 0.5
        anchors.leftMargin: width * 0.5

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onClicked: {
                Qt.quit()
            }
            onEntered: {
                powerAnimation.from = 1
                powerAnimation.to = 1.2
                powerAnimation.target = parent
                powerAnimation.start()
            }
            onExited: {
                powerAnimation.from = 1.2
                powerAnimation.to = 1
                powerAnimation.target = parent
                powerAnimation.start()
            }

        }
    }

    Rectangle {
        id: powermenuRect
        height: closeButton.height
        width: ( height * powermenu.button_getcount() ) + (( height - 1 ) * 0.5)
        color: "transparent"
        anchors.right: closeButton.left
        anchors.rightMargin: closeButton.width * 0.5
        anchors.top: parent.top
        anchors.topMargin: height * 0.5

        RowLayout {
            id: powermenuRow
            anchors.fill: parent
            spacing: closeButton.width * 0.5
            Repeater {
                id: rowRepeater
                model: powermenu.button_getcount()

                Image {
                    height: powermenuRect.height
                    width: height
                    source: powermenu.button_geticon(index)
                    fillMode: Image.PreserveAspectFit

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            poweraction.run(powermenu.button_getcommand(index))
                        }
                        onEntered: {
                            powerAnimation.from = 1
                            powerAnimation.to = 1.2
                            powerAnimation.target = parent
                            powerAnimation.start()
                        }
                        onExited: {
                            powerAnimation.from = 1.2
                            powerAnimation.to = 1
                            powerAnimation.target = parent
                            powerAnimation.start()
                        }
                    }
                }
            }
        }
    }
    NumberAnimation {
        id: powerAnimation
        property: "scale"
        duration: 50
        easing.type: Easing.InOutQuad
    }
}
