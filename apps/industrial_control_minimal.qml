import QtQuick 2.14
import QtQuick.Layouts 1.3

Item {
    id: window
    visible: true

    Rectangle {
        id: backgroundrect
        width: window.width
        height: window.height
        property int count: 0
        Image {
            id: backgroundimage
            source:"/images/Background.png"
            width: parent.width
            height: parent.height
        }

        Image {
            source: "/images/Center_Box.png"
            anchors.top: parent.top
            anchors.topMargin: window.height * 0.05
            anchors.bottom: parent.bottom
            anchors.bottomMargin: window.height * 0.05
            anchors.right: parent.right
            anchors.rightMargin: window.width * 0.05
            anchors.left: parent.left
            anchors.leftMargin: window.width * 0.65

            Rectangle {
                anchors.top: parent.top
                anchors.left: parent.left
                width: parent.width
                height: parent.height * 0.5
                color: "transparent"


                CircularGauge {
                    id: motorspeed1
                    maximumValue: 130
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    height: parent.height * 0.75
                    width: parent.height
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
            Text {
                    id: motor1text
                    text: qsTr("Motor-1 RPM Control")
                    color: "#FFFFFF"
                    anchors.bottom: motorspeed1.top
                    anchors.bottomMargin: parent.height * 0.1
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: parent.width * 0.07
                }
                Rectangle {
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    width: parent.width * 0.1
                    height: parent.width * 0.3
                    anchors.rightMargin: parent.width * 0.05
                    color: "transparent"
                    Image {
                        id: plusbox1
                        height: parent.width
                        width: height
                        source: "/images/Plus_Box.png"
                        anchors.top: parent.top
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                if (motorspeed1.count1 < motorspeed1.maximumValue) {
                                    motorspeed1.count1 += 10
                                }
                            }
                        }
                    }
                    Rectangle {
                        id: valuebox1
                        height: parent.width
                        width: height
                        anchors.top: plusbox1.bottom
                        color: "transparent"
                        Text {
                            text: motorspeed1.count1
                            font.pixelSize: parent.width * 0.6
                            color: "white"
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }
                    Image {
                        id: minusbox1
                        height: parent.width
                        width: height
                        source: "/images/Minux_Box.png"
                        anchors.left: parent.left
                        anchors.top: valuebox1.bottom
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                if (motorspeed1.count1 > 0) {
                                    motorspeed1.count1 -= 10
                                }
                            }
                        }
                    }
                }

            }

            Rectangle {
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                width: parent.width
                height: parent.height * 0.5
                color: "transparent"
                CircularGauge {
                    id: motorspeed2
                    maximumValue: 130
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    height: parent.height * 0.75
                    width: parent.height
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
        Text {
                    id: motor2text
                    text: qsTr("Motor-1 RPM Control")
                    color: "#FFFFFF"
                    anchors.bottom: motorspeed2.top
                    anchors.bottomMargin: parent.height * 0.1
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: parent.width * 0.07
                }
                Rectangle {
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    width: parent.width * 0.1
                    height: parent.width * 0.3
                    anchors.rightMargin: parent.width * 0.05
                    color: "transparent"
                    Image {
                        id: plusbox2
                        height: parent.width
                        width: height
                        source: "/images/Plus_Box.png"
                        anchors.top: parent.top
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                if (motorspeed2.count1 < motorspeed2.maximumValue) {
                                    motorspeed2.count1 += 10
                                }
                            }
                        }
                    }
                    Rectangle {
                        id: valuebox2
                        height: parent.width
                        width: height
                        anchors.top: plusbox2.bottom
                        color: "transparent"
                        Text {
                            text: motorspeed2.count1
                            font.pixelSize: parent.width * 0.6
                            horizontalAlignment: Text.AlignHCenter
                            color: "white"
                        }
                    }
                    Image {
                        id: minusbox2
                        height: parent.width
                        width: height
                        source: "/images/Minux_Box.png"
                        anchors.left: parent.left
                        anchors.top: valuebox2.bottom
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                if (motorspeed2.count1 > 0) {
                                    motorspeed2.count1 -= 10
                                }
                            }
                        }
                    }
                }

            }
        }

        Image {
            id: centreb
            source: "/images/Center_Box.png"
            anchors.top: parent.top
            anchors.topMargin: window.height * 0.05
            anchors.bottom: parent.bottom
            anchors.bottomMargin: window.height * 0.05
            anchors.right: parent.right
            anchors.rightMargin: window.width * 0.38
            anchors.left: parent.left
            anchors.leftMargin: window.width * 0.05

            Rectangle {
                height: parent.height * 0.5
                width: parent.width
                anchors.top: parent.top
                anchors.left: parent.left
                color: "transparent"

                Gauge {
                    id: gauge1
                    minimumValue: 0
                    value: motorspeed1.count1 / 1.3
                    maximumValue: 100
                    anchors.centerIn: parent
                    orientation: Qt.Horizontal
                    width: parent.width * 0.8
                    height: parent.height * 0.2
                    anchors.bottom: parent.bottom
                    anchors.topMargin: parent.height * 0.2
                    anchors.leftMargin: parent.width * 0.1
                }
        Text {
                    id: motortemp1text
                    text: qsTr("Motor-1 Temperature")
                    color: "#FFFFFF"
                    anchors.bottom: gauge1.top
                    anchors.bottomMargin: parent.height * 0.1
            anchors.left: gauge1.left
                    font.pixelSize: parent.width * 0.04
                }
            }
            Rectangle {
                height: parent.height * 0.5
                width: parent.width
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                color: "transparent"
                Gauge {
                    id: gauge2
                    minimumValue: 0
                    value: motorspeed2.count1 / 1.3
                    maximumValue: 100
                    anchors.centerIn: parent
                    orientation: Qt.Horizontal
                    width: parent.width * 0.8
                    height: parent.height * 0.2
                    anchors.bottom: parent.bottom
                    anchors.topMargin: parent.height * 0.7
                    anchors.leftMargin: parent.width * 0.1
                }
        Text {
                    id: motortemp2text
                    text: qsTr("Motor-2 Temperature")
                    color: "#FFFFFF"
                    anchors.bottom: gauge2.top
                    anchors.bottomMargin: parent.height * 0.1
            anchors.left: gauge2.left
                    font.pixelSize: parent.width * 0.04
                }

            }
        }
    }
}
