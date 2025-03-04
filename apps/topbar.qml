import QtQml 2.1
import QtQuick 2.14
import QtQuick.Controls 2.1
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


    Rectangle {
        id: powermenuRect
        height: closeButton.height
        width: ((parent.height / 3) * (powermenu.button_getcount() + 1)) * 1.5
        color: "transparent"
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: height * 0.5

        RowLayout {
            id: powermenuRow
            anchors.fill: parent
            spacing: 2
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
            Image {
                id: closeButton
                height: powermenuRect.height
                width: height
                source: "file:///opt/ti-apps-launcher/assets/close.png"
                fillMode: Image.PreserveAspectFit

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

        }
    }
    NumberAnimation {
        id: powerAnimation
        property: "scale"
        duration: 10
        easing.type: Easing.InOutQuad
    }
}
