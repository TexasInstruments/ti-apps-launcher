import QtQuick 2.15
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Shapes 1.15
import Qt5Compat.GraphicalEffects

Rectangle {
    anchors.fill: parent
    color: "transparent"
    RadialGradient {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#707B7C" }
            GradientStop { position: 0.5; color: "#424949" }
            GradientStop { position: 1.0; color: "#B3B6B7" }
        }
    }
    Rectangle {
        id: topHeadings
        width: parent.width
        height: parent.height * 0.05
        color: "transparent"
        Rectangle {
            id: topHeading1
            anchors.left: parent.left
            anchors.top: parent.top
            width: parent.width * 0.375
            height: parent.height
            color: "transparent"
            Text {
                id: motor1ControlPanelHeading
                text: "Motor-1 Control Panel"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                color: "white"
                font.pixelSize: 30
            }
        }
        Rectangle {
            id: topHeading2
            anchors.left: topHeading1.right
            anchors.top: parent.top
            width: parent.width * 0.375
            height: parent.height
            color: "transparent"
            Text {
                id: motor2ControlPanelHeading
                text: "Motor-2 Control Panel"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                color: "white"
                font.pixelSize: 30
            }
        }
    }

    Rectangle {
        id: motor1ControlPanel
        width: parent.width * 0.25
        height: parent.height * 0.95
        anchors.left: parent.left
        anchors.top: topHeadings.bottom
        anchors.topMargin: parent.height * 0.01
        color: "transparent"
        // border.color: "white"
        // border.width: parent.width * 0.001

        CircularGauge {
            id: ammeter1

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: parent.height * 0.065

            height: parent.height * 0.35
            width: height
            minimumValue: 0
            maximumValue: 20
            value: 6
            labelStepSize: 2
            minorTickmarkCount: 4

            Behavior on value {
                NumberAnimation {
                    duration: 500
                }
            }
        }
        Rectangle {
            id: ammeter1Control

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: ammeter1.bottom
            anchors.topMargin: parent.height * 0.005

            height: parent.height * 0.05
            width: parent.width * 0.8
            color: "transparent"
            Image {
                id: ammeter1minus
                width: parent.width * 0.2
                height: parent.height
                anchors.left: parent.left
                fillMode: Image.PreserveAspectFit
                source: "/images/Minux_Box.png"

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        ammeter1.value = (ammeter1.value == ammeter1.minimumValue) ? ammeter1.minimumValue : (ammeter1.value - 2)
                    }
                    onEntered: {
                        ammeter1minusScaleAnim.from = 1
                        ammeter1minusScaleAnim.to = 1.2
                        ammeter1minusScaleAnim.start()
                    }
                    onExited: {
                        ammeter1minusScaleAnim.from = 1.2
                        ammeter1minusScaleAnim.to = 1
                        ammeter1minusScaleAnim.start()
                    }

                }
                NumberAnimation {
                    id: ammeter1minusScaleAnim
                    target: ammeter1minus
                    property: "scale"
                    duration: 100
                    easing.type: Easing.InOutQuad
                }
            }

            TextField {
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width * 0.4
                height: parent.height
                text: ammeter1.value.toFixed(1);
                horizontalAlignment: TextInput.AlignHCenter
                font.pixelSize: width * 0.2
                readOnly: true
            }
            Image {
                id: ammeter1plus
                width: parent.width * 0.2
                height: parent.height
                anchors.right: parent.right
                fillMode: Image.PreserveAspectFit
                source: "/images/Plus_Box.png"

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        ammeter1.value = (ammeter1.value == ammeter1.maximumValue) ? ammeter1.maximumValue : (ammeter1.value + 2)
                    }
                    onEntered: {
                        ammeter1plusScaleAnim.from = 1
                        ammeter1plusScaleAnim.to = 1.2
                        ammeter1plusScaleAnim.start()
                    }
                    onExited: {
                        ammeter1plusScaleAnim.from = 1.2
                        ammeter1plusScaleAnim.to = 1
                        ammeter1plusScaleAnim.start()
                    }

                }
                NumberAnimation {
                    id: ammeter1plusScaleAnim
                    target: ammeter1plus
                    property: "scale"
                    duration: 100
                    easing.type: Easing.InOutQuad
                }
            }
        }
        /***************************************************************************************************************/
        CircularGauge {
            id: manometer1

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: ammeter1Control.bottom
            anchors.topMargin: parent.height * 0.065

            height: parent.height * 0.35
            width: height
            minimumValue: 0
            maximumValue: 100
            value: 70
            labelStepSize: 10
            minorTickmarkCount: 5

            Behavior on value {
                NumberAnimation {
                    duration: 500
                }
            }
        }
        Rectangle {
            id: manometer1Control

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: manometer1.bottom
            anchors.topMargin: parent.height * 0.005

            height: parent.height * 0.05
            width: parent.width * 0.8
            color: "transparent"
            Image {
                id: manometer1minus
                width: parent.width * 0.2
                height: parent.height
                anchors.left: parent.left
                fillMode: Image.PreserveAspectFit
                source: "/images/Minux_Box.png"

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        manometer1.value = (manometer1.value == manometer1.minimumValue) ? manometer1.minimumValue : (manometer1.value - 10)
                    }
                    onEntered: {
                        manometer1minusScaleAnim.from = 1
                        manometer1minusScaleAnim.to = 1.2
                        manometer1minusScaleAnim.start()
                    }
                    onExited: {
                        manometer1minusScaleAnim.from = 1.2
                        manometer1minusScaleAnim.to = 1
                        manometer1minusScaleAnim.start()
                    }

                }
                NumberAnimation {
                    id: manometer1minusScaleAnim
                    target: manometer1minus
                    property: "scale"
                    duration: 100
                    easing.type: Easing.InOutQuad
                }
            }

            TextField {
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width * 0.4
                height: parent.height
                text: manometer1.value.toFixed(1);
                horizontalAlignment: TextInput.AlignHCenter
                font.pixelSize: width * 0.2
                readOnly: true
            }
            Image {
                id: manometer1plus
                width: parent.width * 0.2
                height: parent.height
                anchors.right: parent.right
                fillMode: Image.PreserveAspectFit
                source: "/images/Plus_Box.png"

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        manometer1.value = (manometer1.value == manometer1.maximumValue) ? manometer1.maximumValue : (manometer1.value + 10)
                    }
                    onEntered: {
                        manometer1plusScaleAnim.from = 1
                        manometer1plusScaleAnim.to = 1.2
                        manometer1plusScaleAnim.start()
                    }
                    onExited: {
                        manometer1plusScaleAnim.from = 1.2
                        manometer1plusScaleAnim.to = 1
                        manometer1plusScaleAnim.start()
                    }

                }
                NumberAnimation {
                    id: manometer1plusScaleAnim
                    target: manometer1plus
                    property: "scale"
                    duration: 100
                    easing.type: Easing.InOutQuad
                }
            }
        }
    }
    Rectangle {
        id: motor1StatsPanel
        width: parent.width * 0.125
        height: parent.height * 0.95
        anchors.left: motor1ControlPanel.right
        anchors.top: topHeadings.bottom
        anchors.topMargin: parent.height * 0.01
        color: "transparent"
        Text {
            id: thermometer1Text
            text: "Temperature"
            color: "white"
            font.pixelSize: 25
            anchors.top: parent.top
            anchors.topMargin: parent.height * 0.025
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Gauge {
            id: thermometer1
            minimumValue: 0
            value: speedometer1.value / speedometer1.maximumValue * 130
            maximumValue: 130
            anchors.top: thermometer1Text.bottom
            anchors.topMargin: parent.height * 0.025
            anchors.horizontalCenter: parent.horizontalCenter
            height: parent.height * 0.8
            width: parent.width * 0.15

            style: GaugeStyle {
                valueBar: Rectangle {
                    implicitWidth: thermometer1.width
                    color: Qt.rgba(thermometer1.value / thermometer1.maximumValue, 1-thermometer1.value / thermometer1.maximumValue , 0 , 1)
                }
                background: Rectangle {
                    color: "#D0D3D4"
                }
                tickmarkLabel:  Text {
                    font.pixelSize: thermometer1.width * 0.4
                    text: styleData.value
                    color: (styleData.value <= thermometer1.value) ? "#e34c22" : "white"
                    font.bold: true
                    antialiasing: true
                }
            }

            NumberAnimation {
                duration: 500
            }
        }
        Rectangle {
            width: parent.parent.width * 0.002
            height: parent.height
            color: "#212F3D"
            anchors.right: parent.right
        }
        Switch {
            id: automanualButton1
            checked: false
            height: parent.height * 0.04
            width: parent.width * 0.7
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height * 0.04
            anchors.horizontalCenter: parent.horizontalCenter
            indicator: Rectangle {
                implicitWidth: parent.width
                implicitHeight: parent.height
                x: automanualButton1.leftPadding
                y: parent.height / 2 - height / 2
                radius: implicitHeight / 2
                color: automanualButton1.checked ? "#566673" : "#ffffff"
                border.color: automanualButton1.checked ? "#ffffff" : "#D0D3D4"

                Rectangle {
                    x: automanualButton1.checked ? parent.width - width : 0
                    implicitHeight: parent.height * 1.2
                    width: height
                    anchors.verticalCenter: parent.verticalCenter
                    radius: implicitHeight
                    color: "#1B2631"
                    border.color: automanualButton1.checked ? "#D0D3D4" : "#ffffff"
                }

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    width: parent.width
                    leftPadding: 10
                    rightPadding: 10
                    text: automanualButton1.checked ? "Manual" : "Auto"
                    font.pixelSize: parent.height * 0.8
                    horizontalAlignment: automanualButton1.checked ? Text.AlignLeft : Text.AlignRight
                    color: automanualButton1.checked ? "#ffffff" : "#1B2631"
                }
            }
            onClicked: {
                if (checked === true) {
                    speedometer1.manual = true
                    timer1.stop()
                    automanualButton2.checked = false
                    speedometer2.manual = false
                    timer2.start()
                } else {
                    speedometer1.manual = false
                    timer1.start()
                    automanualButton2.checked = true
                    speedometer2.manual = true
                    timer2.stop()
                }
            }
        }
    }
    Rectangle {
        id: motor2ControlPanel
        width: parent.width * 0.25
        height: parent.height * 0.95
        anchors.left: motor1StatsPanel.right
        anchors.top: topHeadings.bottom
        anchors.topMargin: parent.height * 0.01
        color: "transparent"
        // border.color: "white"
        // border.width: parent.width * 0.001

        CircularGauge {
            id: ammeter2

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: parent.height * 0.065

            height: parent.height * 0.35
            width: height
            minimumValue: 0
            maximumValue: 20
            value: 12
            labelStepSize: 2
            minorTickmarkCount: 4

            Behavior on value {
                NumberAnimation {
                    duration: 500
                }
            }
        }
        Rectangle {
            id: ammeter2Control

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: ammeter2.bottom
            anchors.topMargin: parent.height * 0.005

            height: parent.height * 0.05
            width: parent.width * 0.8
            color: "transparent"
            Image {
                id: ammeter2minus
                width: parent.width * 0.2
                height: parent.height
                anchors.left: parent.left
                fillMode: Image.PreserveAspectFit
                source: "/images/Minux_Box.png"

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        ammeter2.value = (ammeter2.value == ammeter2.minimumValue) ? ammeter2.minimumValue : (ammeter2.value - 2)
                    }
                    onEntered: {
                        ammeter2minusScaleAnim.from = 1
                        ammeter2minusScaleAnim.to = 1.2
                        ammeter2minusScaleAnim.start()
                    }
                    onExited: {
                        ammeter2minusScaleAnim.from = 1.2
                        ammeter2minusScaleAnim.to = 1
                        ammeter2minusScaleAnim.start()
                    }

                }
                NumberAnimation {
                    id: ammeter2minusScaleAnim
                    target: ammeter2minus
                    property: "scale"
                    duration: 100
                    easing.type: Easing.InOutQuad
                }
            }
            TextField {
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width * 0.4
                height: parent.height
                text: ammeter2.value.toFixed(1);
                horizontalAlignment: TextInput.AlignHCenter
                font.pixelSize: width * 0.2
                readOnly: true
            }
            Image {
                id: ammeter2plus
                width: parent.width * 0.2
                height: parent.height
                anchors.right: parent.right
                fillMode: Image.PreserveAspectFit
                source: "/images/Plus_Box.png"

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        ammeter2.value = (ammeter2.value == ammeter2.maximumValue) ? ammeter2.maximumValue : (ammeter2.value + 2)
                    }
                    onEntered: {
                        ammeter2plusScaleAnim.from = 1
                        ammeter2plusScaleAnim.to = 1.2
                        ammeter2plusScaleAnim.start()
                    }
                    onExited: {
                        ammeter2plusScaleAnim.from = 1.2
                        ammeter2plusScaleAnim.to = 1
                        ammeter2plusScaleAnim.start()
                    }

                }
                NumberAnimation {
                    id: ammeter2plusScaleAnim
                    target: ammeter2plus
                    property: "scale"
                    duration: 100
                    easing.type: Easing.InOutQuad
                }
            }
        }
        /***************************************************************************************************************/
        CircularGauge {
            id: manometer2

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: ammeter2Control.bottom
            anchors.topMargin: parent.height * 0.065

            height: parent.height * 0.35
            width: height
            minimumValue: 0
            maximumValue: 100
            value: 40
            labelStepSize: 10
            minorTickmarkCount: 5

            Behavior on value {
                NumberAnimation {
                    duration: 500
                }
            }
        }
        Rectangle {
            id: manometer2Control

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: manometer2.bottom
            anchors.topMargin: parent.height * 0.005

            height: parent.height * 0.05
            width: parent.width * 0.8
            color: "transparent"
            Image {
                id: manometer2minus
                width: parent.width * 0.2
                height: parent.height
                anchors.left: parent.left
                fillMode: Image.PreserveAspectFit
                source: "/images/Minux_Box.png"

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        manometer2.value = (manometer2.value == manometer2.minimumValue) ? manometer2.minimumValue : (manometer2.value - 10)
                    }
                    onEntered: {
                        manometer2minusScaleAnim.from = 1
                        manometer2minusScaleAnim.to = 1.2
                        manometer2minusScaleAnim.start()
                    }
                    onExited: {
                        manometer2minusScaleAnim.from = 1.2
                        manometer2minusScaleAnim.to = 1
                        manometer2minusScaleAnim.start()
                    }

                }
                NumberAnimation {
                    id: manometer2minusScaleAnim
                    target: manometer2minus
                    property: "scale"
                    duration: 100
                    easing.type: Easing.InOutQuad
                }
            }
            TextField {
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width * 0.4
                height: parent.height
                text: manometer2.value.toFixed(1);
                horizontalAlignment: TextInput.AlignHCenter
                font.pixelSize: width * 0.2
                readOnly: true
            }
            Image {
                id: manometer2plus
                width: parent.width * 0.2
                height: parent.height
                anchors.right: parent.right
                fillMode: Image.PreserveAspectFit
                source: "/images/Plus_Box.png"

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        manometer2.value = (manometer2.value == manometer2.maximumValue) ? manometer2.maximumValue : (manometer2.value + 10)
                    }
                    onEntered: {
                        manometer2plusScaleAnim.from = 1
                        manometer2plusScaleAnim.to = 1.2
                        manometer2plusScaleAnim.start()
                    }
                    onExited: {
                        manometer2plusScaleAnim.from = 1.2
                        manometer2plusScaleAnim.to = 1
                        manometer2plusScaleAnim.start()
                    }

                }
                NumberAnimation {
                    id: manometer2plusScaleAnim
                    target: manometer2plus
                    property: "scale"
                    duration: 100
                    easing.type: Easing.InOutQuad
                }
            }
        }
    }
    Rectangle {
        id: motor2StatsPanel
        width: parent.width * 0.125
        height: parent.height * 0.95
        anchors.left: motor2ControlPanel.right
        anchors.top: topHeadings.bottom
        anchors.topMargin: parent.height * 0.01
        color: "transparent"
        Text {
            id: thermometer2Text
            text: "Temperature"
            color: "white"
            font.pixelSize: 25
            anchors.top: parent.top
            anchors.topMargin: parent.height * 0.025
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Gauge {
            id: thermometer2
            minimumValue: 0
            value: speedometer2.value / speedometer2.maximumValue * 130
            maximumValue: 130
            anchors.top: thermometer2Text.bottom
            anchors.topMargin: parent.height * 0.025
            anchors.horizontalCenter: parent.horizontalCenter
            height: parent.height * 0.8
            width: parent.width * 0.15

            style: GaugeStyle {
                valueBar: Rectangle {
                    implicitWidth: thermometer2.width
                    color: Qt.rgba(thermometer2.value / thermometer2.maximumValue, 1-thermometer2.value / thermometer2.maximumValue , 0 , 1)
                }
                background: Rectangle {
                    color: "#D0D3D4"
                }
                tickmarkLabel:  Text {
                    font.pixelSize: thermometer2.width * 0.4
                    text: styleData.value
                    color: (styleData.value <= thermometer2.value) ? "#e34c22" : "white"
                    antialiasing: true
                    font.bold: true
                }
            }

            NumberAnimation {
                duration: 500
            }
        }
        Rectangle {
            width: parent.parent.width * 0.002
            height: parent.height
            color: "#212F3D"
            anchors.right: parent.right
        }
        Switch {
            id: automanualButton2
            checked: true
            height: parent.height * 0.04
            width: parent.width * 0.7
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height * 0.04
            anchors.horizontalCenter: parent.horizontalCenter
            indicator: Rectangle {
                implicitWidth: parent.width
                implicitHeight: parent.height
                x: automanualButton2.leftPadding
                y: parent.height / 2 - height / 2
                radius: implicitHeight/2
                color: automanualButton2.checked ? "#566573" : "#ffffff"
                border.color: automanualButton2.checked ? "#ffffff" : "#D0D3D4"

                Rectangle {
                    x: automanualButton2.checked ? parent.width - width : 0
                    implicitHeight: parent.height * 1.2
                    width: height
                    anchors.verticalCenter: parent.verticalCenter
                    radius: implicitHeight
                    color: "#1B2631"
                    border.color: automanualButton2.checked ? "#D0D3D4" : "#ffffff"
                }

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    width: parent.width
                    leftPadding: 10
                    rightPadding: 10
                    text: automanualButton2.checked ? "Manual" : "Auto"
                    font.pixelSize: parent.height * 0.8
                    horizontalAlignment: automanualButton2.checked ? Text.AlignLeft : Text.AlignRight
                    color: automanualButton2.checked ? "#ffffff" : "#1B2631"
                }
            }
            onClicked: {
                if (checked === true) {
                    speedometer2.manual = true
                    timer2.stop()
                    automanualButton1.checked = false
                    speedometer1.manual = false
                    timer1.start()
                } else {
                    speedometer2.manual = false
                    timer2.start()
                    automanualButton1.checked = true
                    speedometer1.manual = true
                    timer1.stop()
                }
            }
        }
    }
    Rectangle {
        id: motorsSpeedsPanel
        width: parent.width * 0.25
        height: parent.height * 0.95
        anchors.left: motor2StatsPanel.right
        anchors.top: parent.top
        anchors.topMargin: parent.height * 0.01
        color: "transparent"

        Rectangle {
            id: speedometer1Display
            width: parent.width
            height: parent.height * 0.5
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            color: "transparent"

            Text {
                id: speedometer1Text
                text: "Motor-1 Speed Control"
                color: "white"
                font.pixelSize: 25
                anchors.top: parent.top
                anchors.topMargin: parent.height * 0.05
                anchors.horizontalCenter: parent.horizontalCenter
            }

            CircularGauge {
                id: speedometer1

                property bool manual: true
                property bool incrementing: true
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: speedometer1Text.bottom
                anchors.topMargin: parent.height * 0.025

                height: parent.height * 0.7
                width: height
                minimumValue: 0
                maximumValue: 160
                labelStepSize: 20
                minorTickmarkCount: 4

                Behavior on value {
                    NumberAnimation {
                        duration: 400;
                    }
                }
            }
            Rectangle {
                id: speedometer1Control
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: speedometer1.bottom
                anchors.topMargin: parent.height * 0.005
                height: parent.height * 0.1
                width: parent.width * 0.6
                color: "transparent"
                Image {
                    id: speedometer1minus
                    width: parent.width * 0.2
                    height: parent.height
                    anchors.left: parent.left
                    fillMode: Image.PreserveAspectFit
                    source: "/images/Minux_Box.png"

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        enabled: speedometer1.manual
                        onClicked: {
                            speedometer1.value = (speedometer1.value == speedometer1.minimumValue) ? speedometer1.minimumValue : (speedometer1.value - 20)
                        }
                        onEntered: {
                            speedometer1minusScaleAnim.from = 1
                            speedometer1minusScaleAnim.to = 1.2
                            speedometer1minusScaleAnim.start()
                        }
                        onExited: {
                            speedometer1minusScaleAnim.from = 1.2
                            speedometer1minusScaleAnim.to = 1
                            speedometer1minusScaleAnim.start()
                        }

                    }
                    NumberAnimation {
                        id: speedometer1minusScaleAnim
                        target: speedometer1minus
                        property: "scale"
                        duration: 100
                        easing.type: Easing.InOutQuad
                    }
                }
                Image {
                    id: speedometer1plus
                    width: parent.width * 0.2
                    height: parent.height
                    anchors.right: parent.right
                    fillMode: Image.PreserveAspectFit
                    source: "/images/Plus_Box.png"

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        enabled: speedometer1.manual
                        onClicked: {
                            speedometer1.value = (speedometer1.value == speedometer1.maximumValue) ? speedometer1.maximumValue : (speedometer1.value + 20)
                        }
                        onEntered: {
                            speedometer1plusScaleAnim.from = 1
                            speedometer1plusScaleAnim.to = 1.2
                            speedometer1plusScaleAnim.start()
                        }
                        onExited: {
                            speedometer1plusScaleAnim.from = 1.2
                            speedometer1plusScaleAnim.to = 1
                            speedometer1plusScaleAnim.start()
                        }

                    }
                    NumberAnimation {
                        id: speedometer1plusScaleAnim
                        target: speedometer1plus
                        property: "scale"
                        duration: 100
                        easing.type: Easing.InOutQuad
                    }
                }
            }
            Timer {
                id: timer1
                repeat: true; running: true; interval: 500
                triggeredOnStart: automanualButton1.checked ? false : true
                property bool flicker: false
                onTriggered: {
                    if (speedometer1.incrementing === true) {
                        if (!flicker) {
                            speedometer1.value = (speedometer1.value <= speedometer1.maximumValue) ? (speedometer1.value + 20) : (speedometer1.maximumValue)
                            speedometer1.incrementing = (speedometer1.value > speedometer1.maximumValue - 10) ? false : true
                            flicker = true
                        } else {
                            speedometer1.value = (speedometer1.value <= speedometer1.maximumValue) ? (speedometer1.value - 5) : (speedometer1.maximumValue)
                            flicker = false
                        }
                    } else {
                        if (!flicker) {
                            speedometer1.value = (speedometer1.value >= speedometer1.minimumValue) ? (speedometer1.value - 20) : (speedometer1.minimumValue)
                            speedometer1.incrementing = (speedometer1.value < speedometer1.minimumValue + 10) ? true : false
                            flicker = true
                        } else {
                            speedometer1.value = (speedometer1.value >= speedometer1.minimumValue) ? (speedometer1.value + 5) : (speedometer1.minimumValue)
                            flicker = false
                        }
                    }
                }
            }
            Rectangle {
                width: parent.width
                height: parent.parent.height * 0.001
                color: "#212F3D"
                anchors.bottom: parent.bottom
            }
        }
        Rectangle {
            id: speedometer2Display
            width: parent.width
            height: parent.height * 0.5
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            color: "transparent"

            Text {
                id: speedometer2Text
                text: "Motor-2 Speed Control"
                color: "white"
                font.pixelSize: 25
                anchors.top: parent.top
                anchors.topMargin: parent.height * 0.05
                anchors.horizontalCenter: parent.horizontalCenter
            }

            CircularGauge {
                id: speedometer2

                property bool manual: true
                property bool incrementing: true
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: speedometer2Text.bottom
                anchors.topMargin: parent.height * 0.025

                height: parent.height * 0.7
                width: height
                minimumValue: 0
                maximumValue: 160
                labelStepSize: 20
                minorTickmarkCount: 4

                Behavior on value {
                    NumberAnimation {
                        duration: 600;
                    }
                }
            }
            Rectangle {
                id: speedometer2Control
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: speedometer2.bottom
                anchors.topMargin: parent.height * 0.05
                height: parent.height * 0.1
                width: parent.width * 0.6
                color: "transparent"

                Image {
                    id: speedometer2minus
                    width: parent.width * 0.2
                    height: parent.height
                    anchors.left: parent.left
                    fillMode: Image.PreserveAspectFit
                    source: "/images/Minux_Box.png"

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        enabled: speedometer2.manual
                        onClicked: {
                            speedometer2.value = (speedometer2.value == speedometer2.minimumValue) ? speedometer2.minimumValue : (speedometer2.value - 20)
                        }
                        onEntered: {
                            speedometer2minusScaleAnim.from = 1
                            speedometer2minusScaleAnim.to = 1.2
                            speedometer2minusScaleAnim.start()
                        }
                        onExited: {
                            speedometer2minusScaleAnim.from = 1.2
                            speedometer2minusScaleAnim.to = 1
                            speedometer2minusScaleAnim.start()
                        }

                    }
                    NumberAnimation {
                        id: speedometer2minusScaleAnim
                        target: speedometer2minus
                        property: "scale"
                        duration: 100
                        easing.type: Easing.InOutQuad
                    }
                }
                Image {
                    id: speedometer2plus
                    width: parent.width * 0.2
                    height: parent.height
                    anchors.right: parent.right
                    fillMode: Image.PreserveAspectFit
                    source: "/images/Plus_Box.png"

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        enabled: speedometer2.manual
                        onClicked: {
                            speedometer2.value = (speedometer2.value == speedometer2.maximumValue) ? speedometer2.maximumValue : (speedometer2.value + 20)
                        }
                        onEntered: {
                            speedometer2plusScaleAnim.from = 1
                            speedometer2plusScaleAnim.to = 1.2
                            speedometer2plusScaleAnim.start()
                        }
                        onExited: {
                            speedometer2plusScaleAnim.from = 1.2
                            speedometer2plusScaleAnim.to = 1
                            speedometer2plusScaleAnim.start()
                        }

                    }
                    NumberAnimation {
                        id: speedometer2plusScaleAnim
                        target: speedometer2plus
                        property: "scale"
                        duration: 100
                        easing.type: Easing.InOutQuad
                    }
                }
            }
            Timer {
                id: timer2
                repeat: true; running: false; interval: 700
                triggeredOnStart: automanualButton2.checked ? false : true
                property bool flicker: false
                onTriggered: {
                    if (speedometer2.incrementing === true) {
                        if (!flicker) {
                            speedometer2.value = (speedometer2.value <= speedometer2.maximumValue) ? (speedometer2.value + 20) : (speedometer2.maximumValue)
                            speedometer2.incrementing = (speedometer2.value > speedometer2.maximumValue - 10) ? false : true
                            flicker = true
                        } else {
                            speedometer2.value = (speedometer2.value <= speedometer2.maximumValue) ? (speedometer2.value - 5) : (speedometer2.maximumValue)
                            flicker = false
                        }
                    } else {
                        if (!flicker) {
                            speedometer2.value = (speedometer2.value >= speedometer2.minimumValue) ? (speedometer2.value - 20) : (speedometer2.minimumValue)
                            speedometer2.incrementing = (speedometer2.value < speedometer2.minimumValue + 10) ? true : false
                            flicker = true
                        } else {
                            speedometer2.value = (speedometer2.value >= speedometer2.minimumValue) ? (speedometer2.value + 5) : (speedometer2.minimumValue)
                            flicker = false
                        }
                    }
                }
            }
        }
    }
}
