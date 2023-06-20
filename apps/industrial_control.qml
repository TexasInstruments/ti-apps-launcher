import QtQuick 2.14
import QtQuick.Window 2.14
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtQuick.Layouts 1.3
Rectangle{
    id: window
    height: Screen.desktopAvailableHeight * 0.6
    width: Screen.desktopAvailableWidth * 0.825
    Rectangle {
        id: backgroundrect
        width: window.width
        height: window.height
        property int count: 0
        property int autocontrolmotor1: 0
        property int autocontrolmotor2: 0
        Image {
            id: backgroundimage
            source:"../images/Background.png"
            width: parent.width
            height: parent.height
        }
        //Image {
        //    id: tilogoimage
        //    source: "../images/Texas-Instrument.png"
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
            source: "../images/Top_Righ_Box.png"
            anchors.top: parent.top
            anchors.topMargin: window.height * 0.01
            anchors.bottom: parent.bottom
            anchors.bottomMargin: window.height * 0.52
            anchors.right: parent.right
            anchors.rightMargin: window.width * 0.05
            anchors.left: parent.left
            anchors.leftMargin: window.width * 0.62
            Text {
                text: qsTr("Motor-1 RPM Control")
                color: "#FFFFFF"
                anchors.top: parent.top
                anchors.topMargin: window.height * 0.02
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: parent.width * 0.05
            }
            CircularGauge {
                id: motorspeed1
                maximumValue: 130
                anchors.top: parent.top
                anchors.topMargin: window.height * 0.07
                anchors.left: parent.left
                anchors.leftMargin: window.width * 0.03
                width: parent.width * 0.8
                height: parent.height * 0.8
                property int count1: 0
                value: count1
                Behavior on value {
                    NumberAnimation {
                        duration: 200
                    }
                }
                Component.onCompleted: forceActiveFocus()
                style: CircularGaugeStyle {
                    id: style

                    function degreesToRadians(degrees) {
                        return degrees * (Math.PI / 180);
                    }

                    background: Canvas {
                        onPaint: {
                            var ctx = getContext("2d");
                            ctx.reset();

                            ctx.beginPath();
                            ctx.strokeStyle = "#e34c22";
                            ctx.lineWidth = outerRadius * 0.02;

                            ctx.arc(outerRadius, outerRadius, outerRadius - ctx.lineWidth / 2,
                                degreesToRadians(valueToAngle(0) - 90), degreesToRadians(valueToAngle(130) - 90));
                            ctx.stroke();
                        }
                    }

                    tickmark: Rectangle {
                        visible: styleData.value < 80 || styleData.value % 10 == 0
                        implicitWidth: outerRadius * 0.02
                        antialiasing: true
                        implicitHeight: outerRadius * 0.06
                        color: styleData.value >= 80 ? "#e34c22" : "#e5e5e5"
                    }

                    minorTickmark: Rectangle {
                        visible: styleData.value < 80
                        implicitWidth: outerRadius * 0.01
                        antialiasing: true
                        implicitHeight: outerRadius * 0.03
                        color: "#e5e5e5"
                    }

                    tickmarkLabel:  Text {
                        font.pixelSize: Math.max(6, outerRadius * 0.1)
                        text: styleData.value
                        color: styleData.value >= 80 ? "#e34c22" : "#e5e5e5"
                        antialiasing: true
                    }

                    needle: Rectangle {
                        y: outerRadius * 0.15
                        implicitWidth: outerRadius * 0.03
                        implicitHeight: outerRadius * 0.9
                        antialiasing: true
                        color: "#e5e5e5"
                    }

                    foreground: Item {
                        Rectangle {
                            width: outerRadius * 0.2
                            height: width
                            radius: width / 2
                            color: "#e5e5e5"
                            anchors.centerIn: parent
                        }
                    }
                }
            }
            Rectangle {
                id: rectbox1
                color: "transparent"
                anchors.verticalCenter: parent.verticalCenter
                width: parent.width * 0.10
                height: width * 3
                anchors.right: parent.right
                anchors.rightMargin: parent.width * 0.015
                Text {
                    id: motor1text
                    text: qsTr("0")
                    color: "#FFFFFF"
                    font.pixelSize: parent.width * 0.20
                    anchors.centerIn: parent
                    visible: false
                }
                Image {
                    id: minusbox1
                    source: "../images/Minux_Box.png"
                    fillMode: Image.PreserveAspectFit
                    width: parent.width
                    height: width
                    anchors.bottom: parent.bottom
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
                    source: "../images/Plus_Box.png"
                    fillMode: Image.PreserveAspectFit
                    width: parent.width
                    height: width
                    anchors.top: parent.top
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
            source: "../images/Bottom_Right_Box.png"
            anchors.top: toprb.bottom
            anchors.topMargin: window.height * 0.005
            anchors.left: toprb.left
            width: toprb.width
            height: toprb.height
            Text {
                text: qsTr("Motor-2 RPM Control")
                color: "#FFFFFF"
                anchors.top: parent.top
                anchors.topMargin: window.height * 0.02
                anchors.left: parent.left
                anchors.leftMargin: window.width * 0.08
                font.pixelSize: parent.width * 0.05
            }
            CircularGauge {
                id: motorspeed2
                maximumValue: 130
                anchors.top: parent.top
                anchors.topMargin: window.height * 0.07
                anchors.left: parent.left
                anchors.leftMargin: window.width * 0.03
                width: parent.width * 0.8
                height: parent.height * 0.8
                property int count2: 0
                value: count2
                Behavior on value {
                    NumberAnimation {
                        duration: 200
                    }
                }
                style: CircularGaugeStyle {
                    id: style

                    function degreesToRadians(degrees) {
                        return degrees * (Math.PI / 180);
                    }

                    background: Canvas {
                        onPaint: {
                            var ctx = getContext("2d");
                            ctx.reset();

                            ctx.beginPath();
                            ctx.strokeStyle = "#e34c22";
                            ctx.lineWidth = outerRadius * 0.02;

                            ctx.arc(outerRadius, outerRadius, outerRadius - ctx.lineWidth / 2,
                                degreesToRadians(valueToAngle(0) - 90), degreesToRadians(valueToAngle(130) - 90));
                            ctx.stroke();
                        }
                    }

                    tickmark: Rectangle {
                        visible: styleData.value < 80 || styleData.value % 10 == 0
                        implicitWidth: outerRadius * 0.02
                        antialiasing: true
                        implicitHeight: outerRadius * 0.06
                        color: styleData.value >= 80 ? "#e34c22" : "#e5e5e5"
                    }

                    minorTickmark: Rectangle {
                        visible: styleData.value < 80
                        implicitWidth: outerRadius * 0.01
                        antialiasing: true
                        implicitHeight: outerRadius * 0.03
                        color: "#e5e5e5"
                    }

                    tickmarkLabel:  Text {
                        font.pixelSize: Math.max(6, outerRadius * 0.1)
                        text: styleData.value
                        color: styleData.value >= 80 ? "#e34c22" : "#e5e5e5"
                        antialiasing: true
                    }

                    needle: Rectangle {
                        y: outerRadius * 0.15
                        implicitWidth: outerRadius * 0.03
                        implicitHeight: outerRadius * 0.9
                        antialiasing: true
                        color: "#e5e5e5"
                    }

                    foreground: Item {
                        Rectangle {
                            width: outerRadius * 0.2
                            height: width
                            radius: width / 2
                            color: "#e5e5e5"
                            anchors.centerIn: parent
                        }
                    }
                }
            }
            Rectangle {
                id: rectbox2
                color: "transparent"
                anchors.verticalCenter: parent.verticalCenter
                width: parent.width * 0.10
                height: width * 3
                anchors.right: parent.right
                anchors.rightMargin: parent.width * 0.015
                Text {
                    id: motor2text
                    text: qsTr("0")
                    color: "#FFFFFF"
                    font.pixelSize: parent.width * 0.20
                    anchors.centerIn: parent
                    visible: false
                }
                Image {
                    id: minusbox2
                    source: "../images/Minux_Box.png"
                    fillMode: Image.PreserveAspectFit
                    width: parent.width
                    height: width
                    anchors.bottom: parent.bottom
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
                    source: "../images/Plus_Box.png"
                    fillMode: Image.PreserveAspectFit
                    width: parent.width
                    height: width
                    anchors.top: parent.top
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
            source: "../images/Center_Box.png"
            anchors.top: toprb.top
            anchors.bottom: bottomrb.bottom
            anchors.right: parent.right
            anchors.rightMargin: window.width * 0.38
            anchors.left: parent.left
            anchors.leftMargin: window.width * 0.01
            Image {
                source: "../images/Motor_Temp.png"
                anchors.top: parent.top
                anchors.topMargin: parent.height * 0.005
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Rectangle {
                id: motor1tempbar
                height: parent.height * 0.01
                width: parent.width * 0.7
                anchors.top: parent.top
                anchors.topMargin: parent.height * 0.25
                anchors.left: parent.left
                anchors.leftMargin: parent.width* 0.15
                color: "black"
                Rectangle {
                    id: motor1bar
                    color: "steelblue"
                    width: 0
                    height: parent.height
                }
            }
            Text {
                text: qsTr("Motor 1")
                color: "#FFFFFF"
                anchors.top : motor1tempbar.bottom
                anchors.left: motor1tempbar.left
                font.pixelSize: parent.width * 0.03
            }
            Rectangle {
                id: motor2tempbar
                height: motor1tempbar.height
                width: motor1tempbar.width
                anchors.bottom: parent.bottom
                anchors.bottomMargin: parent.height * 0.25
                anchors.left: motor1tempbar.left
                color: "black"
                Rectangle {
                    id: motor2bar
                    color: "steelblue"
                    width: 0
                    height: parent.height
                }
            }
            Text {
                text: qsTr("Motor 2")
                color: "#FFFFFF"
                anchors.top : motor2tempbar.bottom
                anchors.left: motor2tempbar.left
                font.pixelSize: parent.width * 0.03
            }
        }
        Rectangle{
            id: statusheader
            width: parent.width * 0.2
            height: parent.height * 0.05
            Text {
                text: qsTr("Status Message:")
                anchors.centerIn: parent
                color: "#FFFFFF"
                font.pixelSize: parent.width * 0.12
            }
            color: "transparent"
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            Text {
                id: textupdate
                text: qsTr("Automatic Control")
                anchors.top: parent.top
                anchors.left: parent.right
                color: "#14AFC0"
                font.pixelSize: parent.width * 0.1
            }
        }
        Image {
            id: powerimage
            source: "../images/bluerect.png"
            fillMode: Image.PreserveAspectFit
            height: statusheader.height
            width: statusheader.width * 0.33
            anchors.left: parent.left
            anchors.leftMargin: parent.width * 0.5
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height * 0.01
            Image {
                id:slidebutton
                visible: true
                source: "../images/modebutton.png"
                fillMode: Image.PreserveAspectFit
                width: parent.width * 0.4
                height: parent.height 
                anchors.left: parent.left
                anchors.leftMargin: parent.width * 0.1
                anchors.verticalCenter: parent.verticalCenter
            }
            Image {
                id:slidebutton2
                visible: false
                source: "../images/modebutton.png"
                fillMode: Image.PreserveAspectFit
                width: parent.width * 0.4
                height: parent.height 
                anchors.right: parent.right
                anchors.rightMargin: parent.width * 0.1
                anchors.verticalCenter: parent.verticalCenter
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if(backgroundrect.count == 1) {
                        slidebutton.visible = true
                        slidebutton2.visible = false
                        backgroundrect.count = 0
                        textupdate.text = "Automatic Control"
                        motorspeed1.count1 = 0
                        motor1text.text = motorspeed1.count1
                        motor1bar.width = 0
                        motorspeed2.count2 = 0
                        motor2text.text = motorspeed2.count2
                        motor2bar.width = 0
                        autotimer1.running = true
                        backgroundrect.autocontrolmotor1 = 0
                        autotimer2.running = true
                        backgroundrect.autocontrolmotor2 = 0
                    }
                    else {
                        slidebutton.visible = false
                        slidebutton2.visible = true
                        backgroundrect.count = 1
                        textupdate.text = "Manual Control"
                        autotimer1.running = false
                        autotimer2.running = false
                    }
                }
                //onPressAndHold: {
                //    textupdate.text = "App closing in 3 seconds"
                //    delaytext.running = true
                //}
                //Timer {
                //    id: delaytext
                //    interval: 3000
                //    running: false
                //    onTriggered: Qt.quit()
                //}
            }
        }
        Timer {
            id: autotimer1
            interval: 1000
            running: true
            repeat: true
            onTriggered: {
                if(backgroundrect.autocontrolmotor1 == 0){
                    motorspeed1.count1 +=10
                    if (motorspeed1.count1 < 130) {
                        motor1bar.width = motor1tempbar.width * 0.0076 * motorspeed1.count1
                    }
                    else  {
                        motor1bar.width = motor1tempbar.width
                        motorspeed1.count1 = 130
                        backgroundrect.autocontrolmotor1 = 1                                        
                    }
                }
                else {
                    motorspeed1.count1 -=10
                    if ( motorspeed1.count1 <= 0) {
                        backgroundrect.autocontrolmotor1 = 0
                        motor1bar.width = 0
                    }
                    else {
                        motor1bar.width = motor1tempbar.width * 0.0076 * motorspeed1.count1
                    }
                }
            }
        }  
        Timer {
            id: autotimer2
            interval: 1250
            running: true
            repeat: true
            onTriggered: {
                if(backgroundrect.autocontrolmotor2 == 0) {
                    motorspeed2.count2 +=10
                    if (motorspeed2.count2 < 130) {
                        motor2bar.width = motor2tempbar.width * 0.0076 * motorspeed2.count2
                    }
                    else if (motorspeed2.count2 >= 130) {
                        motor2bar.width = motor2tempbar.width
                        motorspeed2.count2 = 130
                        motor2text.text = motorspeed2.count2
                        backgroundrect.autocontrolmotor2 = 1
                    }
                }
                else {
                    motorspeed2.count2 -=10
                    if(motorspeed2.count2 <= 0) {
                        backgroundrect.autocontrolmotor2 = 0
                        motor2bar.width = 0
                        motor2text.text = 0 
                    }
                    else {
                        motor2bar.width = motor2tempbar.width * 0.0076 * motorspeed2.count2
                    }
                }
            }
        }      
    }
}
