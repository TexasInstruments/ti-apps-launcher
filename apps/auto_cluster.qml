import QtQuick 2.15
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Shapes 1.15
import Qt5Compat.GraphicalEffects

Rectangle {
    width: 1920
    height: 1200
    color: "#000000"
    id: window

    RadialGradient {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "black" }
            GradientStop { position: 0.5; color: "black" }
            GradientStop { position: 0.8; color: "#3498DB" }
        }
    }

    property int gear: 0
    property bool halt: true
    property bool fueling: true
    property string distance: '0.0'

    CircularGauge {
        id: speedometer

        anchors.left: parent.left
        anchors.leftMargin: parent.width * 0.05
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.height * 0.1

        height: parent.height * 0.55
        width: height
        minimumValue: 0
        maximumValue: 160
        style: CircularGaugeStyle {
            labelStepSize: 20
            needle: Rectangle {
                id: speedometer_needle
                y: outerRadius * 0.15
                implicitWidth: outerRadius * 0.03
                implicitHeight: outerRadius * 0.9
                antialiasing: true
                color: "#F1C40F"
            }
            function degreesToRadians(degrees) {
                return degrees * (Math.PI / 180);
            }

            background: Rectangle {
                id: speedometer_bg
                implicitHeight: accelerometer.height
                implicitWidth: accelerometer.width
                color: "transparent"
                anchors.centerIn: parent
                radius: 360

                Canvas {
                    property int value: speedometer.value

                    anchors.fill: parent
                    onPaint: {
                        var ctx = getContext("2d");
                        ctx.reset();

                        ctx.beginPath();
                        ctx.strokeStyle = "#e34c22";
                        ctx.lineWidth = outerRadius * 0.02;

                        ctx.arc(outerRadius, outerRadius, outerRadius - ctx.lineWidth / 2,
                            degreesToRadians(valueToAngle(100) - 90), degreesToRadians(valueToAngle(160) - 90));
                        ctx.stroke();
                    }
                }
                Canvas {
                    property int minAngle: valueToAngle(speedometer.minimumValue)
                    property int maxAngle: valueToAngle(speedometer.maximumValue)
                    property int value: speedometer.value

                    onValueChanged: requestPaint();
                    anchors.fill: parent
                    onPaint: {
                        var ctx = getContext("2d");
                        ctx.reset();

                        ctx.beginPath();

                        var gradient = ctx.createRadialGradient(outerRadius, outerRadius, 0, outerRadius, outerRadius, outerRadius);
                        gradient.addColorStop(0.00, "#3498DB");
                        gradient.addColorStop(0.71, "black");
                        gradient.addColorStop(1, "black");


                        ctx.fillStyle = gradient;
                        ctx.moveTo(outerRadius,outerRadius);
                        ctx.arc(outerRadius,outerRadius, outerRadius * 0.65,
                            degreesToRadians(valueToAngle((speedometer.value < 65 ? 0 : speedometer.value - 65)) - 90), degreesToRadians(valueToAngle(speedometer.value) - 90));
                        ctx.lineTo(outerRadius,outerRadius);
                        ctx.fill();
                    }
                }
            }

            tickmark: Rectangle {
                visible: styleData.value < 80 || styleData.value % 10 == 0
                implicitWidth: outerRadius * 0.02
                antialiasing: true
                implicitHeight: outerRadius * 0.06
                color: styleData.value >= 100 ? "#e34c22" : "#e5e5e5"
            }

            minorTickmark: Rectangle {
                visible: styleData.value < 100
                implicitWidth: outerRadius * 0.01
                antialiasing: true
                implicitHeight: outerRadius * 0.03
                color: "#e5e5e5"
            }

            tickmarkLabel:  Text {
                font.pixelSize: Math.max(6, outerRadius * 0.1)
                text: styleData.value
                color: (styleData.value <= speedometer.value) ? (styleData.value >= 100) ? "#e34c22" : "#3498DB" : "#e5e5e5"
                antialiasing: true
            }

            foreground: Item {
                Rectangle {
                    width: outerRadius * 0.75
                    height: width
                    radius: width / 2
                    color: "#e5e5e5"
                    anchors.centerIn: parent
                    Text {
                        id: speedText
                        font.pixelSize: Math.max(6, outerRadius * 0.3)
                        text: kphInt
                        color: "black"
                        horizontalAlignment: Text.AlignRight
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        readonly property int kphInt: control.value
                    }
                    Text {
                        text: "Kmph"
                        color: "black"
                        font.pixelSize: Math.max(6, outerRadius * 0.1)
                        anchors.top: speedText.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
            }
        }

        Behavior on value {
            SpringAnimation {
                spring: 1; damping: 0.9; mass: 10;
                velocity: 7.5;
            }
        }
    }

    CircularGauge {
        id: accelerometer

        anchors.right: parent.right
        anchors.rightMargin: parent.width * 0.05
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.height * 0.1
        height: parent.height * 0.55
        width: height

        minimumValue: 0
        maximumValue: 8000

        style: CircularGaugeStyle {
            labelStepSize: 1000
            tickmarkStepSize: 1000
            minorTickmarkCount: 5
            needle: Rectangle {
                id: accelerometer_needle
                y: outerRadius * 0.15
                implicitWidth: outerRadius * 0.03
                implicitHeight: outerRadius * 0.9
                antialiasing: true
                color: "#F1C40F"
            }
            function degreesToRadians(degrees) {
                return degrees * (Math.PI / 180);
            }

            background: Rectangle {
                id: accelerometer_bg
                implicitHeight: accelerometer.height
                implicitWidth: accelerometer.width
                color: "transparent"
                anchors.centerIn: parent
                radius: 360

                Canvas {
                    property int value: accelerometer.value

                    anchors.fill: parent
                    onPaint: {
                        var ctx = getContext("2d");
                        ctx.reset();

                        ctx.beginPath();
                        ctx.strokeStyle = "#e34c22";
                        ctx.lineWidth = outerRadius * 0.02;

                        ctx.arc(outerRadius, outerRadius, outerRadius - ctx.lineWidth / 2,
                            degreesToRadians(valueToAngle(5000) - 90), degreesToRadians(valueToAngle(8000) - 90));
                        ctx.stroke();
                    }
                }
                Canvas {
                    property int minAngle: valueToAngle(accelerometer.minimumValue)
                    property int maxAngle: valueToAngle(accelerometer.maximumValue)
                    property int value: accelerometer.value

                    onValueChanged: requestPaint();
                    anchors.fill: parent
                    onPaint: {
                        var ctx = getContext("2d");
                        ctx.reset();

                        ctx.beginPath();

                        var gradient = ctx.createRadialGradient(outerRadius, outerRadius, 0, outerRadius, outerRadius, outerRadius);
                        gradient.addColorStop(0.00, "#3498DB");
                        gradient.addColorStop(0.71, "black");
                        gradient.addColorStop(1, "black");


                        ctx.fillStyle = gradient;
                        ctx.moveTo(outerRadius,outerRadius);
                        ctx.arc(outerRadius,outerRadius, outerRadius * 0.65,
                            degreesToRadians(valueToAngle((accelerometer.value < 3500 ? 0 : accelerometer.value - 3500)) - 90), degreesToRadians(valueToAngle(accelerometer.value) - 90));
                        ctx.lineTo(outerRadius,outerRadius);
                        ctx.fill();
                    }
                }
            }

            tickmark: Rectangle {
                visible: styleData.value < 5000 || styleData.value % 10 == 0
                implicitWidth: outerRadius * 0.02
                antialiasing: true
                implicitHeight: outerRadius * 0.06
                color: styleData.value >= 5000 ? "#e34c22" : "#e5e5e5"
            }

            minorTickmark: Rectangle {
                visible: styleData.value < 5000
                implicitWidth: outerRadius * 0.01
                antialiasing: true
                implicitHeight: outerRadius * 0.03
                color: "#e5e5e5"
            }

            tickmarkLabel:  Text {
                font.pixelSize: Math.max(6, outerRadius * 0.1)
                text: styleData.value
                color: (styleData.value <= accelerometer.value) ? (styleData.value >= 5000) ? "#e34c22" : "#3498DB" : "#e5e5e5"
                antialiasing: true
            }

            foreground: Item {
                Rectangle {
                    width: outerRadius * 0.75
                    height: width
                    radius: width / 2
                    color: "#e5e5e5"
                    anchors.centerIn: parent
                    Text {
                        id: accelerometerText
                        font.pixelSize: Math.max(6, outerRadius * 0.3)
                        text: kphInt
                        color: "black"
                        horizontalAlignment: Text.AlignRight
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        readonly property int kphInt: control.value
                    }
                    Text {
                        text: "RPM"
                        color: "black"
                        font.pixelSize: Math.max(6, outerRadius * 0.1)
                        anchors.top: accelerometerText.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
            }
        }

        Behavior on value {
            SpringAnimation {
                spring: 5; damping: 1; mass: 10;
                velocity: 1750;
            }
        }
    }

    Rectangle {
        id: digitalmeter
        anchors.bottom: fuelmeter.top
        anchors.bottomMargin: height * 0.2
        anchors.horizontalCenter: parent.horizontalCenter
        height: parent.height * 0.20
        anchors.left: speedometer.right
        anchors.right: accelerometer.left
        color: "transparent"
        radius: width * 0.3
        border.width: 2
        border.color: "#3498DB"

        Text {
            id: digitalmeter_time
            anchors.bottom: digitalmeter_gear.top
            anchors.bottomMargin: digitalmeter.height * 0.1
            anchors.horizontalCenter: parent.horizontalCenter
            color: "white"
            text: Qt.formatTime(new Date(), "hh:mm:ss")
            function set() {
                digitalmeter_time.text = Qt.formatTime(new Date(), "hh:mm:ss")
            }
            font.pixelSize: parent.width * 0.08
        }
        Text {
            id: digitalmeter_gear
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            color: "white"
            font.pixelSize: parent.width * 0.08
        }
        Text {
            id: digitalmeter_odo
            anchors.top: digitalmeter_gear.bottom
            anchors.topMargin: digitalmeter.height * 0.1
            anchors.horizontalCenter: parent.horizontalCenter
            color: "white"
            text: "Kms: " + distance.padStart(8, '0')
            font.pixelSize: parent.width * 0.08
        }
    }

    CircularGauge {
        id: fuelmeter

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.height * 0.1
        height: parent.height * 0.30
        width: height

        minimumValue: 0
        maximumValue: 20
        value: 0

        style: CircularGaugeStyle {
            labelStepSize: 5
            tickmarkStepSize: 0.5
            minorTickmarkCount: 1
            needle: Rectangle {
                id: fuelmeter_needle
                y: outerRadius * 0.15
                implicitWidth: outerRadius * 0.03
                implicitHeight: outerRadius * 0.9
                antialiasing: true
                color: "#F1C40F"
            }
            function degreesToRadians(degrees) {
                return degrees * (Math.PI / 180);
            }

            background: Rectangle {
                implicitHeight: fuelmeter.height
                implicitWidth: fuelmeter.width
                color: "transparent"
                anchors.centerIn: parent
                radius: 360
                Image {
                    anchors.fill: parent
                    source: "qrc://gaugebackground.svg"
                    fillMode: Image.PreserveAspectFit
                    asynchronous: true
                    sourceSize {
                        width: width
                    }
                }
                Canvas {
                    property int value: fuelmeter.value

                    anchors.fill: parent
                    onValueChanged: requestPaint()
                    onPaint: {
                        var ctx = getContext("2d");
                        ctx.reset();

                        ctx.beginPath();
                        ctx.strokeStyle = "#e34c22";
                        ctx.lineWidth = outerRadius * 0.02;

                        ctx.arc(outerRadius, outerRadius, outerRadius - ctx.lineWidth / 2,
                            degreesToRadians(valueToAngle(0) - 90), degreesToRadians(valueToAngle(5) - 90));
                        ctx.stroke();
                        ctx.beginPath();
                        ctx.strokeStyle = "#e5e5e5";
                        ctx.lineWidth = outerRadius * 0.02;

                        ctx.arc(outerRadius, outerRadius, outerRadius - ctx.lineWidth / 2,
                            degreesToRadians(valueToAngle(5) - 90), degreesToRadians(valueToAngle(20) - 90));
                        ctx.stroke();
                    }
                }
            }

            tickmark: Rectangle {
                visible: styleData.value % 2.5 == 0
                implicitWidth: outerRadius * 0.02
                antialiasing: true
                implicitHeight: outerRadius * 0.06
                color: styleData.value <= 5 ? "#e34c22" : "#e5e5e5"
            }

            minorTickmark: Rectangle {
                visible: styleData.value < 5
                implicitWidth: outerRadius * 0.01
                antialiasing: true
                implicitHeight: outerRadius * 0.03
                color: "#e34c22"
            }

            tickmarkLabel:  Text {
                visible: styleData.value <= 5 || styleData.value >= 20
                font.pixelSize: Math.max(6, outerRadius * 0.1)
                text: (styleData.value === 0) ? 'E' : ((styleData.value === 5) ? 'Low' : 'F')
                color: styleData.value <= 5 ? "#e34c22" : "#e5e5e5"
                antialiasing: true
            }

            foreground: Item {
                Rectangle {
                    width: outerRadius / 5
                    height: width
                    radius: width / 2
                    color: "#e5e5e5"
                    anchors.centerIn: parent
                }
                Text {
                    id: fuelmeter_text
                    text: "Fuel"
                    color: fuelmeter.value < 5 ? "#e34c22" : "white"
                    font.pixelSize: Math.max(6, outerRadius * 0.2)
                    anchors.top: parent.bottom
                    anchors.topMargin: -(fuelmeter.height * 0.3)
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }

        Behavior on value {
            NumberAnimation {
                duration: 5000
            }
        }
    }
    Timer {
        interval: 100; running: true; repeat: true
        onTriggered: {
            if ((fuelmeter.value != 0) && (speedometer.value != 0)) {
                distance = (parseFloat(distance) + 0.29).toFixed(2).toString()
            }
            if (fueling == false) {
                if (halt == false) {
                    if ((accelerometer.value == 0) && (gear == 0) && (speedometer.value == 0)) {
                        // Switch to gear #1 and accelerate
                        gear = 1;
                        digitalmeter_gear.text = "Gear: " + "<font color=\"#3498DB\">" + gear + "</font>";
                        accelerometer.value = 3001;
                        speedometer.value = 45;
                        fuelmeter.value = 19;
                    } else if ((accelerometer.value >= 3000) && (gear == 1) && (speedometer.value >= 30)) {
                        // switch gear to #2
                        gear = 2;
                        digitalmeter_gear.text = "Gear: " + "<font color=\"#3498DB\">" + gear + "</font>";
                        accelerometer.value = 2000;
                    } else if ((accelerometer.value <= 2750) && (gear == 2)) {
                        // Accelerate in gear #2
                        accelerometer.value = 4001;
                        speedometer.value = 65;
                        fuelmeter.value = 17.5;
                    } else if ((accelerometer.value >= 4000) && (gear == 2) && (speedometer.value >= 50)) {
                        // switch gear to #3
                        gear = 3;
                        digitalmeter_gear.text = "Gear: " + "<font color=\"#3498DB\">" + gear + "</font>";
                        accelerometer.value = 3000;
                    } else if ((accelerometer.value <= 3750) && (gear == 3)) {
                        // Accelerate in gear #3
                        accelerometer.value = 5001;
                        speedometer.value = 85;
                        fuelmeter.value = 16;
                    } else if ((accelerometer.value >= 5000) && (gear == 3) && (speedometer.value >= 70)) {
                        // switch gear to #4
                        gear = 4;
                        digitalmeter_gear.text = "Gear: " + "<font color=\"#3498DB\">" + gear + "</font>";
                        accelerometer.value = 4000;
                    } else if ((accelerometer.value <= 4750) && (gear == 4)) {
                        // Accelerate in gear #3
                        accelerometer.value = 6001;
                        speedometer.value = 105;
                        fuelmeter.value = 12.5;
                    } else if ((accelerometer.value >= 6000) && (gear == 4) && (speedometer.value >= 90)) {
                        // switch gear to #5
                        gear = 5;
                        digitalmeter_gear.text = "Gear: " + "<font color=\"#3498DB\">" + gear + "</font>";
                        accelerometer.value = 5000;
                    } else if ((accelerometer.value <= 5750) && (gear == 5)) {
                        // Accelerate in gear #5
                        accelerometer.value = 7001;
                        speedometer.value = 125;
                        fuelmeter.value = 9;
                    } else if ((accelerometer.value >= 7000) && (gear == 5) && (speedometer.value >= 110)) {
                        // switch gear to #6
                        gear = 6;
                        digitalmeter_gear.text = "Gear: " + "<font color=\"#3498DB\">" + gear + "</font>";
                        accelerometer.value = 6000;
                    } else if ((accelerometer.value <= 6750) && (gear == 6)) {
                        // Accelerate in gear #6
                        accelerometer.value = 7950;
                        speedometer.value = 145;
                        fuelmeter.value = 5;
                    } else if ((accelerometer.value >= 7850) && (gear == 6) && (speedometer.value >= 140)) {
                        halt = true;
                    }
                } else {
                    if ((speedometer.value >= 140)) {
                        gear = 5;
                        digitalmeter_gear.text = "Gear: " + "<font color=\"#3498DB\">" + gear + "</font>";
                        accelerometer.value = 6600;
                        speedometer.value = 115;
                        fuelmeter.value = 4;
                    } else if ((speedometer.value >= 110)) {
                        gear = 4;
                        digitalmeter_gear.text = "Gear: " + "<font color=\"#3498DB\">" + gear + "</font>";
                        accelerometer.value = 5400;
                        speedometer.value = 95;
                        fuelmeter.value = 3;
                    } else if ((speedometer.value >= 90)) {
                        gear = 3;
                        digitalmeter_gear.text = "Gear: " + "<font color=\"#3498DB\">" + gear + "</font>";
                        accelerometer.value = 4200;
                        speedometer.value = 75;
                        fuelmeter.value = 2;
                    } else if ((speedometer.value >= 70)) {
                        gear = 2;
                        digitalmeter_gear.text = "Gear: " + "<font color=\"#3498DB\">" + gear + "</font>";
                        accelerometer.value = 3100;
                        speedometer.value = 50;
                        fuelmeter.value = 1;
                    } else if ((speedometer.value >= 45)) {
                        gear = 1;
                        digitalmeter_gear.text = "Gear: " + "<font color=\"#3498DB\">" + gear + "</font>";
                        accelerometer.value = 1900;
                        speedometer.value = 25;
                        fuelmeter.value = 0.5;
                    } else if ((speedometer.value >= 20)) {
                        gear = 0;
                        digitalmeter_gear.text = "Gear: " + "<font color=\"#27AE60\">" + "N" + "</font>";
                        accelerometer.value = 0;
                        speedometer.value = 0;
                        fuelmeter.value = 0;
                        fueling = true;
                    }
                }
            } else {
                if (speedometer.value == 0) {
                    fuelmeter.value = fuelmeter.maximumValue;
                    digitalmeter_gear.text = "Gear: " + "<font color=\"#e34c22\">" + "P" + "</font>";
                }
                if (fuelmeter.value == fuelmeter.maximumValue) {
                    fueling = false;
                    halt = false;
                    digitalmeter_gear.text = "Gear: " + "<font color=\"#27AE60\">" + "N" + "</font>";
                }
            }
        }
    }
    Timer {
        interval: 1000 ; repeat: true ; running: true;
        onTriggered: digitalmeter_time.set();
    }
}
