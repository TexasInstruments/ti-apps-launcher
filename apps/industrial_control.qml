import QtQuick 2.2
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import Qt5Compat.GraphicalEffects

Rectangle{
    id: window
    height: parent.height
    width: parent.width
    Rectangle {
        id: backgroundrect
        width: window.width
        height: window.height
        property int count: 0
        property int autocontrolmotor1: 0
        property int autocontrolmotor2: 0
        Image {
            id: backgroundimage
            source:"/images/Background.png"
            width: parent.width
            height: parent.height
        }
        Image {
            id: toprb
            source: "/images/Top_Righ_Box.png"
            anchors.top: parent.top
            anchors.topMargin: window.height * 0.01
            anchors.bottom: parent.bottom
            anchors.bottomMargin: window.height * 0.52
            anchors.right: parent.right
            anchors.rightMargin: window.width * 0.01
            anchors.left: parent.left
            anchors.leftMargin: window.width * 0.74
            Text {
                id: motor1text
                text: qsTr("Motor-1 RPM Control")
                color: "#FFFFFF"
                anchors.top: parent.top
                anchors.topMargin: window.height * 0.02
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: parent.width * 0.07
            }
            CircularGauge {
                id: motorspeed1
                maximumValue: 130
                height: parent.height * 0.8
                width: height
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: parent.height * 0.15
                property int count1: 0
                value: count1
                Behavior on value {
                    NumberAnimation {
                        duration: 200
                    }
                }
                Component.onCompleted: forceActiveFocus()

                style: CircularGaugeStyle {
                    labelStepSize: 10
                    labelInset: outerRadius / 2.2
                    tickmarkInset: outerRadius / 4.2
                    minorTickmarkInset: outerRadius / 4.2
                    minimumValueAngle: -144
                    maximumValueAngle: 144

                    background: Rectangle {
                        implicitHeight: motorspeed1.height
                        implicitWidth: motorspeed1.width
                        color: "white"
                        anchors.centerIn: parent
                        radius: 360

                        Image {
                            anchors.fill: parent
                            source: "/images/gaugebackground.svg"
                            fillMode: Image.PreserveAspectFit
                            asynchronous: true
                            sourceSize {
                                width: width
                            }
                        }

                        Canvas {
                            property int value: motorspeed1.value

                            anchors.fill: parent
                            onValueChanged: requestPaint()

                            function degreesToRadians(degrees) {
                              return degrees * (Math.PI / 180);
                            }

                            onPaint: {
                                var ctx = getContext("2d");
                                ctx.reset();
                                ctx.beginPath();
                                ctx.strokeStyle = "black"
                                ctx.lineWidth = outerRadius
                                ctx.arc(outerRadius,
                                      outerRadius,
                                      outerRadius - ctx.lineWidth / 2,
                                      degreesToRadians(valueToAngle(motorspeed1.value) - 90),
                                      degreesToRadians(valueToAngle(motorspeed1.maximumValue + 1) - 90));
                                ctx.stroke();
                            }
                        }
                    }

                    needle: Item {
                        y: -outerRadius * 0.78
                        height: outerRadius * 0.27
                        Image {
                            id: needle
                            source: "/images/needle.svg"
                            height: parent.height
                            width: height * 0.1
                            asynchronous: true
                            antialiasing: true
                        }

                        Glow {
                            anchors.fill: needle
                            radius: 5
                            samples: 10
                            color: "white"
                            source: needle
                        }
                    }

                    foreground: Item {
                        Text {
                            id: speedLabel
                            anchors.centerIn: parent
                            text: motorspeed1.value.toFixed(0)
                            font.pixelSize: outerRadius * 0.3
                            color: "#e34c22"
                            antialiasing: true
                        }
                    }

                    tickmarkLabel:  Text {
                        font.pixelSize: Math.max(6, outerRadius * 0.1)
                        text: styleData.value
                        color: styleData.value <= motorspeed1.value ? "red" : "#777776"
                        antialiasing: true
                    }

                    tickmark: Image {
                        source: "/images/tickmark.svg"
                        width: outerRadius * 0.018
                        height: outerRadius * 0.15
                        antialiasing: true
                        asynchronous: true
                    }

                    minorTickmark: Rectangle {
                        implicitWidth: outerRadius * 0.01
                        implicitHeight: outerRadius * 0.03

                        antialiasing: true
                        smooth: true
                        color: styleData.value <= motorspeed1.value ? "#e34c22" : "darkGray"
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
                Image {
                    id: minusbox1
                    source: "/images/Minux_Box.png"
                    fillMode: Image.PreserveAspectFit
                    width: parent.width
                    height: width
                    anchors.bottom: parent.bottom
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            minusbox1.source = "/images/minuxboxhovered.png"
                        }
                        onExited: {
                            minusbox1.source = "/images/Minux_Box.png"
                        }
                        onClicked: {
                            if (backgroundrect.count == 1) {
                                minusbox1Animation.start()
                                motorspeed1.count1 -=10
                                thermometer1.value = motorspeed1.count1
                                if (motorspeed1.count1 <= 40) {
                                    red1.active = false
                                    yellow1.active = false
                                    green1.active = true
                                }
                                else if (motorspeed1.count1 <= 90) {
                                    red1.active = false
                                    yellow1.active = true
                                    green1.active = false
                                }
                                else {
                                    red1.active = true
                                    yellow1.active = false
                                    green1.active = false
                                }
                                if(motorspeed1.count1 <= 90) {
                                    alert1glow.spread = 0
                                    tempalert1glow.spread = 0
                                }
                                else {
                                    alert1glow.spread = 0.6
                                    tempalert1glow.spread = 0.6
                                }
                            }
                        }
                    }
                    PropertyAnimation {
                        id: minusbox1Animation
                        target: minusbox1
                        property: "scale"
                        to: 0.5
                        duration: 100
                        easing.type: Easing.InOutQuad
                        onStopped: {
                          minusbox1.scale = 1
                        }
                    }
                }
                Image {
                    id: plusbox1
                    source: "/images/Plus_Box.png"
                    fillMode: Image.PreserveAspectFit
                    width: parent.width
                    height: width
                    anchors.top: parent.top
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            plusbox1.source = "/images/plusboxhovered.png"
                        }
                        onExited: {
                            plusbox1.source = "/images/Plus_Box.png"
                        }
                        onClicked: {
                            if (backgroundrect.count == 1) {
                                plusbox1Animation.start()
                                motorspeed1.count1 +=10
                                thermometer1.value = motorspeed1.count1
                                if (motorspeed1.count1 <= 40) {
                                    red1.active = false
                                    yellow1.active = false
                                    green1.active = true
                                }
                                else if (motorspeed1.count1 <= 90) {
                                    red1.active = false
                                    yellow1.active = true
                                    green1.active = false
                                }
                                else {
                                    red1.active = true
                                    yellow1.active = false
                                    green1.active = false
                                }
                                if(motorspeed1.count1 <= 90) {
                                    alert1glow.spread = 0
                                    tempalert1glow.spread = 0
                                }
                                else {
                                    alert1glow.spread = 0.6
                                    tempalert1glow.spread = 0.6
                                }
                            }
                        }
                    }
                    PropertyAnimation {
                        id: plusbox1Animation
                        target: plusbox1
                        property: "scale"
                        to: 0.5
                        duration: 100
                        easing.type: Easing.InOutQuad
                        onStopped: {
                          plusbox1.scale = 1
                        }
                    }
                }
            }
        }
        Image {
            id: bottomrb
            source: "/images/Bottom_Right_Box.png"
            anchors.top: toprb.bottom
            anchors.topMargin: window.height * 0.005
            anchors.left: toprb.left
            width: toprb.width
            height: toprb.height
            Text {
                id: motor2text
                text: qsTr("Motor-2 RPM Control")
                color: "#FFFFFF"
                anchors.top: parent.top
                anchors.topMargin: window.height * 0.02
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: parent.width * 0.07
            }
            CircularGauge {
                id: motorspeed2
                maximumValue: 130
                height: parent.height * 0.8
                width: height
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: parent.height * 0.15
                property int count2: 0
                value: count2
                Behavior on value {
                    NumberAnimation {
                        duration: 200
                    }
                }
                style: CircularGaugeStyle {
                    labelStepSize: 10
                    labelInset: outerRadius / 2.2
                    tickmarkInset: outerRadius / 4.2
                    minorTickmarkInset: outerRadius / 4.2
                    minimumValueAngle: -144
                    maximumValueAngle: 144

                    background: Rectangle {
                        implicitHeight: motorspeed2.height
                        implicitWidth: motorspeed2.width
                        color: "white"
                        anchors.centerIn: parent
                        radius: 360

                        Image {
                            anchors.fill: parent
                            source: "/images/gaugebackground.svg"
                            fillMode: Image.PreserveAspectFit
                            asynchronous: true
                            sourceSize {
                                width: width
                            }
                        }

                        Canvas {
                            property int value: motorspeed2.value

                            anchors.fill: parent
                            onValueChanged: requestPaint()

                            function degreesToRadians(degrees) {
                              return degrees * (Math.PI / 180);
                            }

                            onPaint: {
                                var ctx = getContext("2d");
                                ctx.reset();
                                ctx.beginPath();
                                ctx.strokeStyle = "black"
                                ctx.lineWidth = outerRadius
                                ctx.arc(outerRadius,
                                      outerRadius,
                                      outerRadius - ctx.lineWidth / 2,
                                      degreesToRadians(valueToAngle(motorspeed2.value) - 90),
                                      degreesToRadians(valueToAngle(motorspeed2.maximumValue + 1) - 90));
                                ctx.stroke();
                            }
                        }
                    }

                    needle: Item {
                        y: -outerRadius * 0.78
                        height: outerRadius * 0.27
                        Image {
                            id: needle
                            source: "/images/needle.svg"
                            height: parent.height
                            width: height * 0.1
                            asynchronous: true
                            antialiasing: true
                        }

                        Glow {
                            anchors.fill: needle
                            radius: 5
                            samples: 10
                            color: "white"
                            source: needle
                        }
                    }

                    foreground: Item {
                        Text {
                            id: speedLabel
                            anchors.centerIn: parent
                            text: motorspeed2.value.toFixed(0)
                            font.pixelSize: outerRadius * 0.3
                            color: "#e34c22"
                            antialiasing: true
                        }
                    }

                    tickmarkLabel:  Text {
                        font.pixelSize: Math.max(6, outerRadius * 0.1)
                        text: styleData.value
                        color: styleData.value <= motorspeed2.value ? "red" : "#777776"
                        antialiasing: true
                    }

                    tickmark: Image {
                        source: "/images/tickmark.svg"
                        width: outerRadius * 0.018
                        height: outerRadius * 0.15
                        antialiasing: true
                        asynchronous: true
                    }

                    minorTickmark: Rectangle {
                        implicitWidth: outerRadius * 0.01
                        implicitHeight: outerRadius * 0.03

                        antialiasing: true
                        smooth: true
                        color: styleData.value <= motorspeed2.value ? "#e34c22" : "darkGray"
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
                Image {
                    id: minusbox2
                    source: "/images/Minux_Box.png"
                    fillMode: Image.PreserveAspectFit
                    width: parent.width
                    height: width
                    anchors.bottom: parent.bottom
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            minusbox2.source = "/images/minuxboxhovered.png"
                        }
                        onExited: {
                            minusbox2.source = "/images/Minux_Box.png"
                        }
                        onClicked: {
                            if (backgroundrect.count == 1) {
                                minusbox2Animation.start()
                                motorspeed2.count2 -=10
                                thermometer2.value = motorspeed2.count2
                                if (motorspeed2.count2 <= 40) {
                                    red2.active = false
                                    yellow2.active = false
                                    green2.active = true
                                }
                                else if (motorspeed2.count2 <= 90) {
                                    red2.active = false
                                    yellow2.active = true
                                    green2.active = false
                                }
                                else {
                                    red2.active = true
                                    yellow2.active = false
                                    green2.active = false
                                }
                                if(motorspeed2.count2 <= 90) {
                                    alert2glow.spread = 0
                                    tempalert2glow.spread = 0
                                }
                                else {
                                    alert2glow.spread = 0.6
                                    tempalert2glow.spread = 0.6
                                }
                                
                            }
                        }
                    }
                    PropertyAnimation {
                        id: minusbox2Animation
                        target: minusbox2
                        property: "scale"
                        to: 0.5
                        duration: 100
                        easing.type: Easing.InOutQuad
                        onStopped: {
                          minusbox2.scale = 1
                        }
                    }
                }
                Image {
                    id: plusbox2
                    source: "/images/Plus_Box.png"
                    fillMode: Image.PreserveAspectFit
                    width: parent.width
                    height: width
                    anchors.top: parent.top
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            plusbox2.source = "/images/plusboxhovered.png"
                        }
                        onExited: {
                            plusbox2.source = "/images/Plus_Box.png"
                        }
                        onClicked: {
                            if (backgroundrect.count == 1) {
                                plusbox2Animation.start()
                                motorspeed2.count2 +=10
                                thermometer2.value = motorspeed2.count2
                                if (motorspeed2.count2 <= 40) {
                                    red2.active = false
                                    yellow2.active = false
                                    green2.active = true
                                }
                                else if (motorspeed2.count2 <= 90) {
                                    red2.active = false
                                    yellow2.active = true
                                    green2.active = false
                                }
                                else {
                                    red2.active = true
                                    yellow2.active = false
                                    green2.active = false
                                }
                                if(motorspeed2.count2 <= 90) {
                                    alert2glow.spread = 0
                                    tempalert2glow.spread = 0
                                }
                                else {
                                    alert2glow.spread = 0.6
                                    tempalert2glow.spread = 0.6
                                }
                                
                            }
                        }
                    }
                    PropertyAnimation {
                        id: plusbox2Animation
                        target: plusbox2
                        property: "scale"
                        to: 0.5
                        duration: 100
                        easing.type: Easing.InOutQuad
                        onStopped: {
                          plusbox2.scale = 1
                        }
                    }
                }
            }
        }
        Image {
            id: centreb
            source: "/images/Center_Box.png"
            anchors.top: toprb.top
            anchors.bottom: bottomrb.bottom
            anchors.right: parent.right
            anchors.rightMargin: window.width * 0.28
            anchors.left: parent.left
            anchors.leftMargin: window.width * 0.01
            Rectangle {
                id: lefthalf
                width: parent.width * 0.5
                
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                color: "transparent"
                Text {
                    id:motor1textcb
                    text: qsTr("MOTOR 1")
                    anchors.top: parent.top
                    anchors.topMargin: parent.height * 0.005
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: parent. width * 0.07
                    color: "white"
                }
                Text {
                    text: qsTr("Current Control")
                    anchors.bottom: motorcurrent1.top
                    anchors.bottomMargin: parent.height * 0.01
                    anchors.horizontalCenter: motorcurrent1.horizontalCenter
                    font.pixelSize: parent. width * 0.04
                    color: "white"
                }
                CircularGauge {
                    id: motorcurrent1
                    maximumValue: 100
                    height: parent.height * 0.45
                    width: height
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width * 0.05
                    anchors.top: motor1textcb.bottom
                    anchors.topMargin: parent.height * 0.1
                    property int count: 40
                    value: count
                    Behavior on value {
                        NumberAnimation {
                            duration: 200
                        }
                    }
                    style: CircularGaugeStyle {
                        id: style
                        minimumValueAngle: -90
                        maximumValueAngle: 90
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
                                    degreesToRadians(valueToAngle(0) - 90), degreesToRadians(valueToAngle(100) - 90));
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
                    id: rectboxcurrent1
                    color: "transparent"
                    height: parent.height * 0.07
                    width: height * 3
                    anchors.horizontalCenter: motorcurrent1.horizontalCenter
                    anchors.bottom: motorcurrent1.bottom
                    anchors.bottomMargin: parent.height * 0.12
                    Image {
                        id: minusboxcurrent1
                        source: "/images/Minux_Box.png"
                        fillMode: Image.PreserveAspectFit
                        height: parent.height
                        width: height
                        anchors.left: parent.left
                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered: {
                                minusboxcurrent1.source = "/images/minuxboxhovered.png"
                            }
                            onExited: {
                                minusboxcurrent1.source = "/images/Minux_Box.png"
                            }
                            onClicked: {
                                motorcurrent1.count -=10
                                minusboxcurrent1Animation.start()
                            }
                        }
                        PropertyAnimation {
                            id: minusboxcurrent1Animation
                            target: minusboxcurrent1
                            property: "scale"
                            to: 0.5
                            duration: 100
                            easing.type: Easing.InOutQuad
                            onStopped: {
                              minusboxcurrent1.scale = 1
                            }
                        }
                    }
                    Image {
                        id: plusboxcurrent1
                        source: "/images/Plus_Box.png"
                        fillMode: Image.PreserveAspectFit
                        height: parent.height
                        width: height
                        anchors.right: parent.right
                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered: {
                                plusboxcurrent1.source = "/images/plusboxhovered.png"
                            }
                            onExited: {
                                plusboxcurrent1.source = "/images/Plus_Box.png"
                            }
                            onClicked: {
                                motorcurrent1.count += 10
                                plusboxcurrent1Animation.start()
                            }
                            
                        }
                        PropertyAnimation {
                            id: plusboxcurrent1Animation
                            target: plusboxcurrent1
                            property: "scale"
                            to: 0.5
                            duration: 100
                            easing.type: Easing.InOutQuad
                            onStopped: {
                              plusboxcurrent1.scale = 1
                            }
                        }
                    }
                }
                Text {
                    text: qsTr("Pressure Control")
                    anchors.bottom: motorpressure1.top
                    anchors.bottomMargin: parent.height * 0.01
                    anchors.horizontalCenter: motorpressure1.horizontalCenter
                    font.pixelSize: parent. width * 0.04
                    color: "white"
                }
                CircularGauge {
                    id: motorpressure1
                    maximumValue: 100
                    height: parent.height * 0.45
                    width: height
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width * 0.05
                    anchors.top: parent.top
                    anchors.topMargin:parent.height * 0.65
                    property int count: 60
                    value: count
                    Behavior on value {
                        NumberAnimation {
                            duration: 200
                        }
                    }
                    style: CircularGaugeStyle {
                        id: style
                        minimumValueAngle: -90
                        maximumValueAngle: 90
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
                                    degreesToRadians(valueToAngle(0) - 90), degreesToRadians(valueToAngle(100) - 90));
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
                    id: rectboxpressure1
                    color: "transparent"
                    height: parent.height * 0.07
                    width: height * 3
                    anchors.horizontalCenter: motorpressure1.horizontalCenter
                    anchors.bottom: motorpressure1.bottom
                    anchors.bottomMargin: parent.height * 0.12
                    Image {
                        id: minusboxpressure1
                        source: "/images/Minux_Box.png"
                        fillMode: Image.PreserveAspectFit
                        height: parent.height
                        width: height
                        anchors.left: parent.left
                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered: {
                                minusboxpressure1.source = "/images/minuxboxhovered.png"
                            }
                            onExited: {
                                minusboxpressure1.source = "/images/Minux_Box.png"
                            }
                            onClicked: {
                                motorpressure1.count -=10
                                minusboxpressure1Animation.start()
                            }
                        }
                        PropertyAnimation {
                            id: minusboxpressure1Animation
                            target: minusboxpressure1
                            property: "scale"
                            to: 0.5
                            duration: 100
                            easing.type: Easing.InOutQuad
                            onStopped: {
                              minusboxpressure1.scale = 1
                            }
                        }
                    }
                    Image {
                        id: plusboxpressure1
                        source: "/images/Plus_Box.png"
                        fillMode: Image.PreserveAspectFit
                        height: parent.height
                        width: height
                        anchors.right: parent.right
                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered: {
                                plusboxpressure1.source = "/images/plusboxhovered.png"
                            }
                            onExited: {
                                plusboxpressure1.source = "/images/Plus_Box.png"
                            }
                            onClicked: {
                                motorpressure1.count += 10
                                plusboxpressure1Animation.start()
                            }
                            
                        }
                        PropertyAnimation {
                            id: plusboxpressure1Animation
                            target: plusboxpressure1
                            property: "scale"
                            to: 0.5
                            duration: 100
                            easing.type: Easing.InOutQuad
                            onStopped: {
                              plusboxpressure1.scale = 1
                            }
                        }
                    }
                }
                Rectangle {
                    id: lightpanel1
                    height: parent.height * 0.075
                    width: height * 3.3
                    anchors.right: thermometer1.right
                    anchors.top: thermometer1.bottom
                    anchors.topMargin: parent.height * 0.02
                    color: "transparent"
                    StatusIndicator {
                        id: red1
                        anchors.left: parent.left
                        height: parent.height
                        width: height
                        color: "red"
                    }
                    StatusIndicator {
                        id: yellow1
                        height: parent.height
                        width: height
                        anchors.horizontalCenter: parent.horizontalCenter
                        color: "orange"
                    }
                    StatusIndicator {
                        id: green1
                        anchors.right: parent.right
                        height: parent.height
                        width: height
                        color: "green"
                    }
                }
                
                Rectangle {
                    id:telltales1
                    anchors.top: thermometer1.top
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width * 0.7
                    anchors.right: thermometer1.left
                    anchors.rightMargin: parent.width* 0.05
                    height: width * 3.5
                    color: "transparent"
                    
                    Image{
                        id: maintainence1
                        source: "/images/maintainence.png"
                        sourceSize: Qt.size(parent.width, parent.height)
                        anchors.top : parent.top
                        width: parent.width 
                        anchors.horizontalCenter: parent.horizontalCenter
                        height: width
                        smooth: true
                        visible: false
                    }
                    Glow {
                        id:maintainence1glow
                        anchors.fill: maintainence1
                        source: maintainence1
                        samples: 32
                        radius: 10
                        color: "dodgerblue"
                        spread: 0
                    }
                    Timer {
                        id: maintainence1timer
                        interval: 500
                        running: true
                        property int flag: 0
                        repeat: true
                        onTriggered: {
                            if (flag == 1) {
                                maintainence1glow.spread = 0.6
                                maintainence1timer.flag = 0
                            }
                            else {
                                maintainence1glow.spread = 0
                                maintainence1timer.flag = 1
                            }
                        }
                    }
                    Image{
                        id: security1
                        source: "/images/security.png"
                        sourceSize: Qt.size(parent.width, parent.height)
                        anchors.top : maintainence1.bottom
                        anchors.topMargin: parent.height * 0.1
                        width: parent.width 
                        anchors.horizontalCenter: parent.horizontalCenter
                        height: width
                        smooth: true
                        visible: false
                    }
                    Glow {
                        id:security1glow
                        anchors.fill: security1
                        source: security1

                        samples: 32
                        radius: 10
                        color: "green"
                        spread: 0.5
                    }
                    Image{
                        id: wifi1
                        source: "/images/wifi.png"
                        sourceSize: Qt.size(parent.width, parent.height)
                        anchors.top : security1.bottom
                        anchors.topMargin: parent.height * 0.07
                        width: parent.width 
                        anchors.horizontalCenter: parent.horizontalCenter
                        height: width
                        smooth: true
                        visible: false
                    }
                    Glow {
                        id:wifi1glow
                        anchors.fill: wifi1
                        source: wifi1

                        samples: 32
                        radius: 10
                        color: "green"
                        spread: 0.5
                    }
                }
                Rectangle {
                    id: criticaltelltales1
                    height:telltales1.height
                    width: telltales1.width
                    anchors.top: parent.top
                    anchors.topMargin: parent.height * 0.55
                    anchors.left: telltales1.left
                    color: "transparent"
                    Image{
                        id: alert1
                        source: "/images/alert.png"
                        sourceSize: Qt.size(parent.width, parent.height)
                        anchors.top : parent.top
                        width: parent.width 
                        anchors.horizontalCenter: parent.horizontalCenter
                        height: width
                        smooth: true
                        visible: false
                    }
                    Glow {
                        id:alert1glow
                        anchors.fill: alert1
                        source: alert1

                        samples: 32
                        radius: 10
                        color: "red"
                        spread: 0
                    }
                    Image{
                        id: tempalert1
                        source: "/images/tempalert.png"
                        sourceSize: Qt.size(parent.width, parent.height)
                        anchors.top : alert1.bottom
                        anchors.topMargin: parent.height * 0.1
                        width: parent.width 
                        anchors.horizontalCenter: parent.horizontalCenter
                        height: width
                        smooth: true
                        visible: false
                    }
                    Glow {
                        id:tempalert1glow
                        anchors.fill: tempalert1
                        source: tempalert1
                        samples: 32
                        radius: 10
                        color: "red"
                        spread: 0
                    }
                    Image{
                        id: lowbattery1
                        source: "/images/low-battery.png"
                        sourceSize: Qt.size(parent.width, parent.height)
                        anchors.top : tempalert1.bottom
                        anchors.topMargin: parent.height * 0.05
                        width: parent.width 
                        anchors.horizontalCenter: parent.horizontalCenter
                        height: width
                        smooth: true
                        visible: false
                    }
                    Glow {
                        id:lowbattery1glow
                        anchors.fill: lowbattery1
                        source: lowbattery1
                        samples: 32
                        radius: 10
                        color: "red"
                        spread: 0
                    }
                }
                Gauge {
                    id: thermometer1
                    minimumValue: 0
                    value: 0
                    maximumValue: 130
                    height: parent.height * 0.7
                    anchors.right: parent.right
                    anchors.rightMargin: parent.width * 0.05
                    anchors.verticalCenter: parent.verticalCenter
                    Behavior on value {
                        NumberAnimation {
                            duration: 1000
                        }
                    }

                    style: GaugeStyle {
                        valueBar: Rectangle {
                            implicitWidth: 16
                            color: Qt.rgba(thermometer1.value / thermometer1.maximumValue, 1-thermometer1.value / thermometer1.maximumValue , 0 , 1)
                        }
                    }
                }
            }

            Rectangle {
                id: righthalf
                width: parent.width * 0.5
                height: parent.height
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                color: "transparent"
                Text {
                    id:motor2textcb
                    text: qsTr("MOTOR 2")
                    anchors.top: parent.top
                    anchors.topMargin: parent.height * 0.005
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: parent. width * 0.07
                    color: "white"
                }
                Text {
                    text: qsTr("Current Control")
                    anchors.bottom: motorcurrent2.top
                    anchors.bottomMargin: parent.height * 0.01
                    anchors.horizontalCenter: motorcurrent2.horizontalCenter
                    font.pixelSize: parent. width * 0.04
                    color: "white"
                }
                CircularGauge {
                    id: motorcurrent2
                    maximumValue: 100
                    height: parent.height * 0.45
                    width: height
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width * 0.05
                    anchors.top: motor2textcb.bottom
                    anchors.topMargin: parent.height * 0.1
                    property int count: 60
                    value: count
                    Behavior on value {
                        NumberAnimation {
                            duration: 200
                        }
                    }
                    style: CircularGaugeStyle {
                        id: style
                        minimumValueAngle: -90
                        maximumValueAngle: 90
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
                                    degreesToRadians(valueToAngle(0) - 90), degreesToRadians(valueToAngle(100) - 90));
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
                    id: rectboxcurrent2
                    color: "transparent"
                    height: parent.height * 0.07
                    width: height * 3
                    anchors.horizontalCenter: motorcurrent2.horizontalCenter
                    anchors.bottom: motorcurrent2.bottom
                    anchors.bottomMargin: parent.height * 0.12
                    Image {
                        id: minusboxcurrent2
                        source: "/images/Minux_Box.png"
                        fillMode: Image.PreserveAspectFit
                        height: parent.height
                        width: height
                        anchors.left: parent.left
                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered: {
                                minusboxcurrent2.source = "/images/minuxboxhovered.png"
                            }
                            onExited: {
                                minusboxcurrent2.source = "/images/Minux_Box.png"
                            }
                            onClicked: {
                                motorcurrent2.count -=10
                                minusboxcurrent2Animation.start()
                            }
                        }
                        PropertyAnimation {
                            id: minusboxcurrent2Animation
                            target: minusboxcurrent2
                            property: "scale"
                            to: 0.5
                            duration: 100
                            easing.type: Easing.InOutQuad
                            onStopped: {
                              minusboxcurrent2.scale = 1
                            }
                        }
                    }
                    Image {
                        id: plusboxcurrent2
                        source: "/images/Plus_Box.png"
                        fillMode: Image.PreserveAspectFit
                        height: parent.height
                        width: height
                        anchors.right: parent.right
                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered: {
                                plusboxcurrent2.source = "/images/plusboxhovered.png"
                            }
                            onExited: {
                                plusboxcurrent2.source = "/images/Plus_Box.png"
                            }
                            onClicked: {
                                motorcurrent2.count += 10
                                plusboxcurrent2Animation.start()
                            }
                            
                        }
                        PropertyAnimation {
                            id: plusboxcurrent2Animation
                            target: plusboxcurrent2
                            property: "scale"
                            to: 0.5
                            duration: 100
                            easing.type: Easing.InOutQuad
                            onStopped: {
                              plusboxcurrent2.scale = 1
                            }
                        }
                    }
                }
                Text {
                    text: qsTr("Pressure Control")
                    anchors.bottom: motorpressure2.top
                    anchors.bottomMargin: parent.height * 0.01
                    anchors.horizontalCenter: motorpressure2.horizontalCenter
                    font.pixelSize: parent. width * 0.04
                    color: "white"
                }
                CircularGauge {
                    id: motorpressure2
                    maximumValue: 100
                    height: parent.height * 0.45
                    width: height
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width * 0.05
                    anchors.top: parent.top
                    anchors.topMargin: parent.height * 0.65
                    property int count: 40
                    value: count
                    
                    Behavior on value {
                        NumberAnimation {
                            duration: 200
                        }
                    }
                    style: CircularGaugeStyle {
                        id: style
                        minimumValueAngle: -90
                        maximumValueAngle: 90
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
                                    degreesToRadians(valueToAngle(0) - 90), degreesToRadians(valueToAngle(100) - 90));
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
                    id: rectboxpressure2
                    color: "transparent"
                    height: parent.height * 0.07
                    width: height * 3
                    anchors.horizontalCenter: motorpressure2.horizontalCenter
                    anchors.bottom: motorpressure2.bottom
                    anchors.bottomMargin: parent.height * 0.12
                    Image {
                        id: minusboxpressure2
                        source: "/images/Minux_Box.png"
                        fillMode: Image.PreserveAspectFit
                        height: parent.height
                        width: height
                        anchors.left: parent.left
                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered: {
                                minusboxpressure2.source = "/images/minuxboxhovered.png"
                            }
                            onExited: {
                                minusboxpressure2.source = "/images/Minux_Box.png"
                            }
                            onClicked: {
                                motorpressure2.count -=10
                                minusboxpressure2Animation.start()
                            }
                        }
                        PropertyAnimation {
                            id: minusboxpressure2Animation
                            target: minusboxpressure2
                            property: "scale"
                            to: 0.5
                            duration: 100
                            easing.type: Easing.InOutQuad
                            onStopped: {
                              minusboxpressure2.scale = 1
                            }
                        }
                    }
                    Image {
                        id: plusboxpressure2
                        source: "/images/Plus_Box.png"
                        fillMode: Image.PreserveAspectFit
                        height: parent.height
                        width: height
                        anchors.right: parent.right
                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered: {
                                plusboxpressure2.source = "/images/plusboxhovered.png"
                            }
                            onExited: {
                                plusboxpressure2.source = "/images/Plus_Box.png"
                            }
                            onClicked: {
                                motorpressure2.count += 10
                                plusboxpressure2Animation.start()
                            }
                        }
                        PropertyAnimation {
                            id: plusboxpressure2Animation
                            target: plusboxpressure2
                            property: "scale"
                            to: 0.5
                            duration: 100
                            easing.type: Easing.InOutQuad
                            onStopped: {
                              plusboxpressure2.scale = 1
                            }
                        }
                    }
                }
                Rectangle {
                    id: lightpanel2
                    height: parent.height * 0.075
                    width: height * 3.3
                    anchors.right: thermometer2.right
                    anchors.top: thermometer2.bottom
                    anchors.topMargin: parent.height * 0.02
                    color: "transparent"
                    StatusIndicator {
                        id: red2
                        anchors.left: parent.left
                        height: parent.height
                        width: height
                        color: "red"
                    }
                    StatusIndicator {
                        id: yellow2
                        height: parent.height
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: height
                        color: "orange"
                    }
                    StatusIndicator {
                        id: green2
                        anchors.right: parent.right
                        height: parent.height
                        width: height
                        color: "green"
                    }
                }
                Rectangle {
                    id:telltales2
                    anchors.top: thermometer2.top
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width * 0.7
                    anchors.right: thermometer2.left
                    anchors.rightMargin: parent.width* 0.05
                    height: width * 3.5
                    color: "transparent"
                    Image{
                        id: maintainence2
                        source: "/images/maintainence.png"
                        sourceSize: Qt.size(parent.width, parent.height)
                        anchors.top : parent.top
                        width: parent.width 
                        anchors.horizontalCenter: parent.horizontalCenter
                        height: width
                        smooth: true
                        visible: false
                    }
                    Glow {
                        id:maintainence2glow
                        anchors.fill: maintainence2
                        source: maintainence2

                        samples: 32
                        radius: 10
                        color: "dodgerblue"
                        spread: 0
                    }
                    Timer {
                        id: maintainence2timer
                        interval: 500
                        running: true
                        property int flag: 0
                        repeat: true
                        onTriggered: {
                            if (flag == 1) {
                                maintainence2glow.spread = 0.6
                                maintainence2timer.flag = 0
                            }
                            else {
                                maintainence2glow.spread = 0
                                maintainence2timer.flag = 1
                            }
                        }
                    }
                    Image{
                        id: security2
                        source: "/images/security.png"
                        sourceSize: Qt.size(parent.width, parent.height)
                        anchors.top : maintainence2.bottom
                        anchors.topMargin: parent.height * 0.1
                        width: parent.width 
                        anchors.horizontalCenter: parent.horizontalCenter
                        height: width
                        smooth: true
                        visible: false
                    }
                    Glow {
                        id:security2glow
                        anchors.fill: security2
                        source: security2

                        samples: 32
                        radius: 10
                        color: "green"
                        spread: 0.5
                    }
                    Image{
                        id: wifi2
                        source: "/images/wifi.png"
                        sourceSize: Qt.size(parent.width, parent.height)
                        anchors.top : security2.bottom
                        anchors.topMargin: parent.height * 0.1
                        width: parent.width 
                        anchors.horizontalCenter: parent.horizontalCenter
                        height: width
                        smooth: true
                        visible: false
                    }
                    Glow {
                        id:wifi2glow
                        anchors.fill: wifi2
                        source: wifi2

                        samples: 32
                        radius: 10
                        color: "green"
                        spread: 0.5
                    }
                }
                Rectangle {
                    id: criticaltelltales2
                    height: telltales2.height
                    width: telltales2.width
                    anchors.top: parent.top
                    anchors.topMargin: parent.height * 0.55
                    anchors.left: telltales2.left
                    color: "transparent"
                    Image{
                        id: alert2
                        source: "/images/alert.png"
                        sourceSize: Qt.size(parent.width, parent.height)
                        anchors.top : parent.top
                        width: parent.width 
                        anchors.horizontalCenter: parent.horizontalCenter
                        height: width
                        smooth: true
                        visible: false
                    }
                    Glow {
                        id:alert2glow
                        anchors.fill: alert2
                        source: alert2

                        samples: 32
                        radius: 10
                        color: "red"
                        spread: 0
                    }
                    Image{
                        id: tempalert2
                        source: "/images/tempalert.png"
                        sourceSize: Qt.size(parent.width, parent.height)
                        anchors.top : alert2.bottom
                        anchors.topMargin: parent.height * 0.1
                        width: parent.width 
                        anchors.horizontalCenter: parent.horizontalCenter
                        height: width
                        smooth: true
                        visible: false
                    }
                    Glow {
                        id:tempalert2glow
                        anchors.fill: tempalert2
                        source: tempalert2

                        samples: 32
                        radius: 10
                        color: "red"
                        spread: 0
                    }
                    Image{
                        id: lowbattery2
                        source: "/images/low-battery.png"
                        sourceSize: Qt.size(parent.width, parent.height)
                        anchors.top : tempalert2.bottom
                        anchors.topMargin: parent.height * 0.05
                        width: parent.width 
                        anchors.horizontalCenter: parent.horizontalCenter
                        height: width
                        smooth: true
                        visible: false
                    }
                    Glow {
                        id:lowbattery2glow
                        anchors.fill: lowbattery2
                        source: lowbattery2
                        samples: 32
                        radius: 10
                        color: "red"
                        spread: 0
                    }
                }
                Gauge {
                    id: thermometer2
                    minimumValue: 0
                    value: 0
                    maximumValue: 130
                    height: parent.height * 0.7
                    anchors.right: parent.right
                    anchors.rightMargin: parent.width * 0.05
                    anchors.verticalCenter: parent.verticalCenter
                    Behavior on value {
                        NumberAnimation {
                            duration: 1000
                        }
                    }

                    style: GaugeStyle {
                        valueBar: Rectangle {
                            implicitWidth: 16
                            color: Qt.rgba(thermometer2.value / thermometer2.maximumValue, 1-thermometer2.value / thermometer2.maximumValue , 0 , 1)
                        }
                    }
                }
            } 
        }
        Rectangle {
            id: powerimage
            height: parent.height * 0.08
            width: parent.width * 0.1
            anchors.left: parent.left
            anchors.leftMargin: parent.width * 0.715
            anchors.bottom: parent.bottom
            color: "transparent"
            Image {
                id:slidebutton
                visible: true
                source: "/images/mode1.png"
                fillMode: Image.PreserveAspectFit
                anchors.fill: parent
            }
            Image {
                id:slidebutton2
                visible: false
                source: "/images/mode2.png"
                fillMode: Image.PreserveAspectFit 
                anchors.fill: parent
            }
            Text {
                id:autotext
                visible:true
                text: "Auto"
                color: "white"
                font.pixelSize: parent.width * 0.1
                anchors.centerIn: parent
            }
            Text {
                id: manualtext
                visible: false
                text: "Manual"
                color: "white"
                font.pixelSize: parent.width * 0.1
                anchors.centerIn: parent
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if(backgroundrect.count == 1) {
                        backgroundrect.count = 0
                        slidebutton.visible = true
                        slidebutton2.visible = false
                        autotext.visible = true
                        manualtext.visible = false
                        
                        motorspeed1.count1 = 0
                        red1.active = false
                        yellow1.active = false
                        green1.active = true
                        
                        motorspeed2.count2 = 0
                        red2.active = false
                        yellow2.active = false
                        green2.active = true

                        autotimer1.running = true
                        backgroundrect.autocontrolmotor1 = 0
                        autotimer2.running = true
                        backgroundrect.autocontrolmotor2 = 0
                    }
                    else {
                        backgroundrect.count = 1
                        slidebutton.visible = false
                        slidebutton2.visible = true
                        autotext.visible = false
                        manualtext.visible = true
                        autotimer1.running = false
                        autotimer2.running = false
                    }
                }
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
                    if (motorspeed1.count1 >= 130) {
                        backgroundrect.autocontrolmotor1 = 1 
                        //video.play()
                    }
                }
                else {
                    motorspeed1.count1 -=10
                    if ( motorspeed1.count1 <= 0) {
                        backgroundrect.autocontrolmotor1 = 0   
                    }
                }
                thermometer1.value = motorspeed1.count1
                if (motorspeed1.count1 <= 40) {
                    red1.active = false
                    yellow1.active = false
                    green1.active = true
                }
                else if (motorspeed1.count1 <= 90) {
                    red1.active = false
                    yellow1.active = true
                    green1.active = false
                    
                }
                else {
                    red1.active = true
                    yellow1.active = false
                    green1.active = false
                }
                if(motorspeed1.count1 <= 90) {
                    alert1glow.spread = 0
                    tempalert1glow.spread = 0
                    
                }
                else {
                    alert1glow.spread = 0.6
                    tempalert1glow.spread = 0.6
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
                    if (motorspeed2.count2 >= 130) {
                        backgroundrect.autocontrolmotor2 = 1
                    }
                }
                else {
                    motorspeed2.count2 -=10
                    if(motorspeed2.count2 <= 0) {
                        backgroundrect.autocontrolmotor2 = 0
                    }
                }
                thermometer2.value = motorspeed2.count2
                if (motorspeed2.count2 <= 40) {
                    red2.active = false
                    yellow2.active = false
                    green2.active = true
                }
                else if (motorspeed2.count2 <= 90) {
                    red2.active = false
                    yellow2.active = true
                    green2.active = false
                }
                else {
                    red2.active = true
                    yellow2.active = false
                    green2.active = false
                }
                if(motorspeed2.count2 <= 90) {
                    alert2glow.spread = 0
                    tempalert2glow.spread = 0
                }
                else {
                    alert2glow.spread = 0.6
                    tempalert2glow.spread = 0.6
                }
            }
        } 
    }
}
