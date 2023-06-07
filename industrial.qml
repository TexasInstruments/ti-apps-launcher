import QtQuick 2.14
import QtQuick.Window 2.14
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtQuick.Layouts 1.3

Window {
    id: window
    visible: true
    width: 640
    height: 480
    //anchors.centerIn: mainWindow
    //visibility: "FullScreen"
    
    title: qsTr("Industrial Control")

    Rectangle {
        id: backgroundrect
        width: window.width
        height: window.height
        property int count: 0
        Image {
            id: backgroundimage
            source:"images/Background.png"
            width: parent.width
            height: parent.height
        }
        Image {
            id: motorimage
            source: "images/servo-drives-icon.png"
            fillMode: Image.PreserveAspectFit
            anchors.left: parent.left 
            anchors.leftMargin: window.width * 0.02
            anchors.right: parent.right
            anchors.rightMargin: window.width * 0.87
            anchors.top: parent.top
            anchors.topMargin: window.height * 0.01
            anchors.bottom: parent.bottom
            anchors.bottomMargin: window.height * 0.80
        }
        //Image {
        //    id: tilogoimage
        //    source: "images/Texas-Instrument.png"
        //    fillMode: Image.PreserveAspectFit
        //    anchors.left: parent.left
        //    anchors.leftMargin: window.width * 0.70
        //    anchors.right: parent.right
        //    anchors.rightMargin: window.width * 0.10
        //    anchors.top: parent.top
        //    anchors.topMargin: window.height * 0.04
        //    anchors.bottom: parent.bottom
        //    anchors.bottomMargin: window.height * 0.80
        //}

        Image {
            id: toprb
            source: "images/Top_Righ_Box.png"
            anchors.top: parent.top
            anchors.topMargin: window.height * 0.15
            anchors.bottom: parent.bottom
            anchors.bottomMargin: window.height * 0.47
            anchors.right: parent.right
            anchors.rightMargin: window.width * 0.09
            anchors.left: parent.left
            anchors.leftMargin: window.width * 0.62

            Text {
                text: qsTr("Motor-1 RPM Control")
                color: "#FFFFFF"
                anchors.top: parent.top
                anchors.topMargin: window.height * 0.02
                anchors.left: parent.left
                anchors.leftMargin: window.width * 0.075
                font.pixelSize: parent.width * 0.05
            }

            CircularGauge {
                id: motorspeed1
                maximumValue: 130
                anchors.top: parent.top
                anchors.topMargin: window.height * 0.07
                anchors.left: parent.left
                anchors.leftMargin: window.width * 0.03
                width: window.width * 0.22
                height: window.height * 0.22
                property int count1: 0
                value: count1
                Behavior on value {
                    NumberAnimation {
                        duration: 200
                    }
                }
                Component.onCompleted: forceActiveFocus()

                style: CircularGaugeStyle {
                    needle: Rectangle {
                        implicitWidth: outerRadius * 0.02
                        implicitHeight: outerRadius * 0.60
                        antialiasing: true
                        color: "#D0001C"
                    }
                    foreground: Item {
                        Rectangle {
                            width: outerRadius * 0.1
                            height: width
                            radius: width / 2
                            color: "#FFFFFF"
                            anchors.centerIn: parent
                        }
                    }
                    tickmarkLabel:  Text {
                        visible: false
                    }

                    tickmark: Rectangle {
                        visible: false
                    }

                    minorTickmark: Rectangle {
                        visible: false
                    }

                    function degreesToRadians(degrees) {
                        return degrees * (Math.PI / 180);
                    }
                    background: Canvas {
                        onPaint: {
                            var ctx = getContext("2d");
                            ctx.reset();

                            ctx.beginPath();
                            ctx.strokeStyle = "#C6C6C6";
                            ctx.lineWidth = outerRadius * 0.04;

                            ctx.arc(outerRadius, outerRadius, outerRadius - ctx.lineWidth / 2,
                                    degreesToRadians(valueToAngle(0) - 90), degreesToRadians(valueToAngle(130) - 90));
                            ctx.stroke();
                        }
                    }
                }
            }


            Image {
                id: rectbox1
                source: "images/Rectangle.png"
                anchors.top: parent.top
                anchors.topMargin: parent.height * 0.75
                anchors.left: parent.left
                anchors.leftMargin: parent.width * 0.33
                width: parent.width * 0.31
                height: parent.height * 0.12
                Text {
                    id: motor1text
                    text: qsTr("0")
                    color: "#FFFFFF"
                    font.pixelSize: parent.width * 0.20
                    anchors.centerIn: parent
                }
                Image {
                    id: minusbox1
                    source: "images/Minux_Box.png"
                    fillMode: Image.PreserveAspectFit
                    width: parent.height
                    height: parent.height
                    x: 0
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if (backgroundrect.count == 1) {
                                motorspeed1.count1 -=10
                                if ( motorspeed1.count1 == 10) {
                                    motor1bar.width = window.width * 0.01
                                    motor1text.text = motorspeed1.count1
                                }
                                else if (motorspeed1.count1 >= 10 && motorspeed1.count1 < 50) {
                                    motor1bar.width -= window.width * 0.025
                                    motor1text.text = motorspeed1.count1
                                }
                                else if (motorspeed1.count1 >= 50 && motorspeed1.count1 < 70) {
                                    motor1bar.width -= window.width * 0.03
                                    motor1text.text = motorspeed1.count1
                                }
                                else if (motorspeed1.count1 >= 70 && motorspeed1.count1 < 100) {
                                    motor1bar.width -= window.width * 0.025
                                    motor1text.text = motorspeed1.count1
                                }
                                else if (motorspeed1.count1 >= 100 && motorspeed1.count1 < 130) {
                                    motor1bar.width -= window.width * 0.03
                                    motor1text.text = motorspeed1.count1
                                }
                                else if (motorspeed1.count1 >= 130) {
                                    motor1bar.width = window.width * 0.34
                                    motorspeed1.count1 = 130
                                    motor1text.text = motorspeed1.count1
                                }
                                else {
                                    motor1bar.width = 0
                                    motorspeed1.count1 = 0
                                    motor1text.text = motorspeed1.count1
                                }
                            }

                        }
                    }
                }
                Image {
                    id: plusbox1
                    source: "images/Plus_Box.png"
                    fillMode: Image.PreserveAspectFit
                    width: parent.height
                    height: parent.height
                    x: parent.width * 0.72
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if (backgroundrect.count == 1) {
                                motorspeed1.count1 +=10
                                if ( motorspeed1.count1 == 10) {
                                    motor1bar.width = window.width * 0.01
                                    motor1text.text = motorspeed1.count1
                                }
                                else if (motorspeed1.count1 >= 10 && motorspeed1.count1 < 50) {
                                    motor1bar.width += window.width * 0.025
                                    motor1text.text = motorspeed1.count1
                                }
                                else if (motorspeed1.count1 >= 50 && motorspeed1.count1 < 70) {
                                    motor1bar.width += window.width * 0.03
                                    motor1text.text = motorspeed1.count1
                                }
                                else if (motorspeed1.count1 >= 70 && motorspeed1.count1 < 100) {
                                    motor1bar.width += window.width * 0.025
                                    motor1text.text = motorspeed1.count1
                                }
                                else if (motorspeed1.count1 >= 100 && motorspeed1.count1 < 130) {
                                    motor1bar.width += window.width * 0.03
                                    motor1text.text = motorspeed1.count1
                                }
                                else if (motorspeed1.count1 >= 130) {
                                    motor1bar.width = window.width * 0.34
                                    motorspeed1.count1 = 130
                                    motor1text.text = motorspeed1.count1
                                }

                                else {
                                    motor1bar.width = 0
                                    motorspeed1.count1 = 0
                                    motor1text.text = motorspeed1.count1
                                }
                            }
                            else {
                                textupdate.text = "Press the ON button to start Motor-1 control"
                            }
                        }
                    }
                }

            }
        }
        Image {
            id: bottomrb
            source: "images/Bottom_Right_Box.png"
            anchors.top: parent.top
            anchors.topMargin: window.height * 0.53
            anchors.bottom: parent.bottom
            anchors.bottomMargin: window.height * 0.09
            anchors.right: parent.right
            anchors.rightMargin: window.width * 0.09
            anchors.left: parent.left
            anchors.leftMargin: window.width * 0.62

            Text {
                text: qsTr("Motor-2 RPM Control")
                color: "#FFFFFF"
                anchors.top: parent.top
                anchors.topMargin: window.height * 0.02
                anchors.left: parent.left
                anchors.leftMargin: window.width * 0.075
                font.pixelSize: parent.width * 0.05
            }
            CircularGauge {
                id: motorspeed2
                maximumValue: 130
                anchors.top: parent.top
                anchors.topMargin: window.height * 0.07
                anchors.left: parent.left
                anchors.leftMargin: window.width * 0.03
                width: window.width * 0.22
                height: window.height * 0.22
                property int count2: 0
                value: count2
                Behavior on value {
                    NumberAnimation {
                        duration: 200
                    }
                }
                style: CircularGaugeStyle {
                    needle: Rectangle {
                        implicitWidth: outerRadius * 0.02
                        implicitHeight: outerRadius * 0.60
                        antialiasing: true
                        color: "#D0001C"
                    }
                    foreground: Item {
                        Rectangle {
                            width: outerRadius * 0.1
                            height: width
                            radius: width / 2
                            color: "#FFFFFF"
                            anchors.centerIn: parent
                        }
                    }
                    tickmarkLabel:  Text {
                        visible: false
                    }

                    tickmark: Rectangle {
                        visible: false
                    }

                    minorTickmark: Rectangle {
                        visible: false
                    }

                    function degreesToRadians(degrees) {
                        return degrees * (Math.PI / 180);
                    }
                    background: Canvas {
                        onPaint: {
                            var ctx = getContext("2d");
                            ctx.reset();

                            ctx.beginPath();
                            ctx.strokeStyle = "#C6C6C6";
                            ctx.lineWidth = outerRadius * 0.04;

                            ctx.arc(outerRadius, outerRadius, outerRadius - ctx.lineWidth / 2,
                                    degreesToRadians(valueToAngle(0) - 90), degreesToRadians(valueToAngle(130) - 90));
                            ctx.stroke();
                        }
                    }
                }
            }
            Image {
                id: rectbox2
                source: "images/Rectangle.png"
                anchors.top: parent.top
                anchors.topMargin: parent.height * 0.75
                anchors.left: parent.left
                anchors.leftMargin: parent.width * 0.33
                width: parent.width * 0.31
                height: parent.height * 0.12
                Text {
                    id: motor2text
                    text: qsTr("0")
                    color: "#FFFFFF"
                    font.pixelSize: parent.width * 0.20
                    anchors.centerIn: parent
                }
                Image {
                    id: minusbox2
                    source: "images/Minux_Box.png"
                    fillMode: Image.PreserveAspectFit
                    width: parent.height
                    height: parent.height
                    x: 0
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if (backgroundrect.count == 1) {
                                motorspeed2.count2 -=10
                                if ( motorspeed2.count2 == 10) {
                                    motor2bar.width = window.width * 0.01
                                    motor2text.text = motorspeed2.count2
                                }
                                else if (motorspeed2.count2 >= 10 && motorspeed2.count2 < 50) {
                                    motor2bar.width -= window.width * 0.025
                                    motor2text.text = motorspeed2.count2
                                }
                                else if (motorspeed2.count2 >= 50 && motorspeed2.count2 < 70) {
                                    motor2bar.width -= window.width * 0.03
                                    motor2text.text = motorspeed2.count2
                                }
                                else if (motorspeed2.count2 >= 70 && motorspeed2.count2 < 100) {
                                    motor2bar.width -= window.width * 0.025
                                    motor2text.text = motorspeed2.count2
                                }
                                else if (motorspeed2.count2 >= 100 && motorspeed2.count2 < 130) {
                                    motor2bar.width -= window.width * 0.03
                                    motor2text.text = motorspeed2.count2
                                }
                                else if (motorspeed2.count2 >= 130) {
                                    motor2bar.width = window.width * 0.34
                                    motorspeed2.count2 = 130
                                    motor2text.text = motorspeed2.count2
                                }
                                else {
                                    motor2bar.width = 0
                                    motorspeed2.count2 = 0
                                    motor2text.text = motorspeed2.count2
                                }
                            }
                        }
                    }
                }
                Image {
                    id: plusbox2
                    source: "images/Plus_Box.png"
                    fillMode: Image.PreserveAspectFit
                    width: parent.height
                    height: parent.height
                    x: parent.width * 0.72
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if (backgroundrect.count == 1) {
                                motorspeed2.count2 +=10
                                if ( motorspeed2.count2 == 10) {
                                    motor2bar.width = window.width * 0.01
                                    motor2text.text = motorspeed2.count2
                                }
                                else if (motorspeed2.count2 >= 10 && motorspeed2.count2 < 50) {
                                    motor2bar.width += window.width * 0.025
                                    motor2text.text = motorspeed2.count2
                                }
                                else if (motorspeed2.count2 >= 50 && motorspeed2.count2 < 70) {
                                    motor2bar.width += window.width * 0.03
                                    motor2text.text = motorspeed2.count2
                                }
                                else if (motorspeed2.count2 >= 70 && motorspeed2.count2 < 100) {
                                    motor2bar.width += window.width * 0.025
                                    motor2text.text = motorspeed2.count2
                                }
                                else if (motorspeed2.count2 >= 100 && motorspeed2.count2 < 130) {
                                    motor2bar.width += window.width * 0.03
                                    motor2text.text = motorspeed2.count2
                                }
                                else if (motorspeed2.count2 >= 130) {
                                    motor2bar.width = window.width * 0.34
                                    motorspeed2.count2 = 130
                                    motor2text.text = motorspeed2.count2
                                }
                                else {
                                    motor2bar.width = 0
                                    motorspeed2.count2 = 0
                                    motor2text.text = motorspeed2.count2
                                }
                            }
                            else {
                                textupdate.text = "Press the ON button to start Motor-2 control"
                            }
                        }
                    }
                }

            }
        }
        Image {
            id: centreb
            source: "images/Center_Box.png"
            anchors.top: parent.top
            anchors.topMargin: window.height * 0.15
            anchors.bottom: parent.bottom
            anchors.bottomMargin: window.height * 0.09
            anchors.right: parent.right
            anchors.rightMargin: window.width * 0.38
            anchors.left: parent.left
            anchors.leftMargin: window.width * 0.15

            Image {
                source: "images/Motor_Temp.png"
                fillMode: Image.PreserveAspectFit
                anchors.top: parent.top
                anchors.topMargin: window.height * 0.03
                anchors.left: parent.left
                anchors.leftMargin: window.width * 0.06
                anchors.right: parent.right
                anchors.rightMargin: window.width * 0.22
                anchors.bottom: parent.bottom
                anchors.bottomMargin: window.height * 0.65
            }
            Image {
                id: motor1image
                Text {
                    id: motor1
                    text: qsTr("Motor 1")
                    y: -1 * parent.height * 1.2
                    color: "#FFFFFF"
                    font.pixelSize: parent.width * 0.04
                }
                source: "images/Repeat_Grid.png"
                fillMode: Image.PreserveAspectFit
                anchors.top: parent.top
                anchors.topMargin: window.height * 0.25
                anchors.left: parent.left
                anchors.leftMargin: window.width * 0.06
                anchors.right: parent.right
                anchors.rightMargin: window.width * 0.07
                anchors.bottom: parent.bottom
                anchors.bottomMargin: window.height * 0.45
                Rectangle {

                    id: motor1tempbar
                    width: motor1image.width
                    height: motor1image.width * 0.05
                    color: "#A0A0A0"
                    anchors.top: motor1.bottom
                    anchors.topMargin: window.height * 0.02
                    Rectangle {
                        id: motor1bar
                        color: "#FFFFFF"
                        width: 0
                        height: parent.height
                    }
                }
            }
            Image {
                id: motor2image
                Text {
                    id: motor2
                    text: qsTr("Motor 2")
                    y: -1 * parent.height * 1.2
                    color: "#FFFFFF"
                    font.pixelSize: parent.width * 0.04
                }
                source: "images/Repeat_Grid.png"
                fillMode: Image.PreserveAspectFit
                anchors.top: parent.top
                anchors.topMargin: window.height * 0.50
                anchors.left: parent.left
                anchors.leftMargin: window.width * 0.06
                anchors.right: parent.right
                anchors.rightMargin: window.width * 0.07
                anchors.bottom: parent.bottom
                anchors.bottomMargin: window.height * 0.20
                Rectangle {
                    id: motor2tempbar
                    width: motor2image.width
                    height: motor2image.width * 0.05
                    color: "#A0A0A0"
                    anchors.top: motor2.bottom
                    anchors.topMargin: window.height * 0.02
                    Rectangle {
                        id: motor2bar
                        color: "#FFFFFF"
                        width: 0
                        height: parent.height
                    }
                }
            }
        }
        Image {
            id: controlimage
            source: "images/Control_Panel_with_text.png"
            fillMode: Image.PreserveAspectFit
            anchors.top: parent.top
            anchors.topMargin: window.height * 0.20
            anchors.bottom: parent.bottom
            anchors.bottomMargin: window.height * 0.77
            anchors.right: parent.right
            anchors.rightMargin: window.width * 0.89
            anchors.left: parent.left
            anchors.leftMargin: window.width * 0.03
            Rectangle{
                id:controlfill
                color: "transparent"
                z: -1
                x: -1 * (parent.width)
                width: parent.width * 2.56
                height: parent.height * 1.5
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        controlfill.color = "#C6C6C6"
                    }
                    onExited: {
                        controlfill.color = "transparent"
                    }
                    onClicked: {
                        controlfill.color = "#C6C6C6"
                        textupdate.text = "Control Panel Selected"
                    }
                    onReleased: {
                        controlfill.color = "transparent"
                    }
                }
            }
        }
        //Image {
        //    id: renderimage
        //    source: "images/3D_with_text.png"
        //    fillMode: Image.PreserveAspectFit
        //    anchors.top: parent.top
        //    anchors.topMargin: window.height * 0.29
        //    anchors.bottom: parent.bottom
        //    anchors.bottomMargin: window.height * 0.68
        //    anchors.right: parent.right
        //    anchors.rightMargin: window.width * 0.94
        //    anchors.left: parent.left
        //    anchors.leftMargin: window.width * 0.03
        //    Rectangle{
        //        id:renderfill
        //        color: "transparent"
        //        z: -1
        //        x: -1 * (parent.width)
        //        width: parent.width * 5.2
        //        height: parent.height * 1.5
        //        MouseArea {
        //            anchors.fill: parent
        //            hoverEnabled: true
        //            onEntered: {
        //                renderfill.color = "#C6C6C6"
        //            }
        //            onExited: {
        //                renderfill.color = "transparent"
        //            }
        //            onClicked: {
        //                renderfill.color = "#C6C6C6"
        //                textupdate.text = "Launching 3D Demo .."
        //                Qt.exit(0x3D)
        //            }
        //            onReleased: {
        //                renderfill.color = "transparent"
        //            }
        //        }
        //    }
        //}
        //Image {
        //    id: analyticsimage
        //    source: "images/Camera_with_text.png"
        //    fillMode: Image.PreserveAspectFit
        //    anchors.top: parent.top
        //    anchors.topMargin: window.height * 0.38
        //    anchors.bottom: parent.bottom
        //    anchors.bottomMargin: window.height * 0.59
        //    anchors.right: parent.right
        //    anchors.rightMargin: window.width * 0.91
        //    anchors.left: parent.left
        //    anchors.leftMargin: window.width * 0.03
        //    Rectangle{
        //        id:analyticsill
        //        color: "transparent"
        //        z: -1
        //        x: -1 * (parent.width)
        //        width: parent.width * 3.1
        //        height: parent.height * 1.5
        //        MouseArea {
        //            anchors.fill: parent
        //            hoverEnabled: true
        //            onEntered: {
        //                analyticsill.color = "#C6C6C6"
        //            }
        //            onExited: {
        //                analyticsill.color = "transparent"
        //            }
        //            onClicked: {
        //                analyticsill.color = "#C6C6C6"
        //                textupdate.text = "Launching Camera Demo .."
        //                Qt.exit(0xC)
        //            }
        //            onReleased: {
        //                analyticsill.color = "transparent"
        //            }
        //        }
        //    }
        //}
        Image {
            id: statusheader
            source: "images/Status_Message.png"
            fillMode: Image.PreserveAspectFit
            anchors.top: parent.top
            anchors.topMargin: window.height * 0.06
            anchors.bottom: parent.bottom
            anchors.bottomMargin: window.height * 0.90
            anchors.right: parent.right
            anchors.rightMargin: window.width * 0.70
            anchors.left: parent.left
            anchors.leftMargin: window.width * 0.15
            Text {
                id: textupdate
                text: qsTr("Press the ON button.")
                anchors.top: parent.top
                anchors.topMargin: parent.height * 1.2
                anchors.left: parent.left
                anchors.leftMargin: parent.width * 0.03
                color: "#14AFC0"
                font.pixelSize: parent.width * 0.12
            }
        }
        Image {
            id: powerimage
            source: "images/On_Button.png"
            fillMode: Image.PreserveAspectFit
            anchors.top: parent.top
            anchors.topMargin: window.height * 0.70
            anchors.bottom: parent.bottom
            anchors.bottomMargin: window.height * 0.16
            anchors.right: parent.right
            anchors.rightMargin: window.width * 0.90
            anchors.left: parent.left
            anchors.leftMargin: window.width * 0.04

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if(backgroundrect.count == 1) {
                        powerimage.source = "images/On_Button.png"
                        backgroundrect.count = 0
                        textupdate.text = "Off Button Pressed"
                        motorspeed1.count1 = 0
                        motor1text.text = motorspeed1.count1
                        motor1bar.width = 0
                        motorspeed2.count2 = 0
                        motor2text.text = motorspeed2.count2
                        motor2bar.width = 0
                    }
                    else {
                        powerimage.source = "images/Off_Button.png"
                        backgroundrect.count = 1
                        textupdate.text = "On Button Pressed"
                    }
                }
                onPressAndHold: {
                    textupdate.text = "App closing in 3 seconds"
                    delaytext.running = true


                }
                Timer {
                    id: delaytext
                    interval: 3000
                    running: false
                    onTriggered: Qt.quit()
                }
            }
        }
    }
}
