import QtQml 2.1
import QtQuick 2.14
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3

Rectangle {
    id: statswindow
    visible: true
    color: "#17252A"

    Rectangle {
        id: backgroundrect
        width: statswindow.width
        height: statswindow.height
        color: "#344045"

        Rectangle {
            id: gpubar
            width: parent.width * 0.05
            height: parent.height * 0.7
            color: "#A0A0A0"
            anchors.top: parent.top
            anchors.topMargin: parent.height * 0.1
            anchors.left: parent.left
            anchors.leftMargin: parent.width * 0.05

            Rectangle {
                id: gpubarfill
                color: "steelblue"
                width: parent.width
                height: 0
                anchors.bottom: parent.bottom
            }

            Text {
                id: gpuload
                text: qsTr("0%")
                color: "#F44336"
                font.pixelSize: parent.width * 0.20
                font.bold: true
                anchors.centerIn: parent
            }

            Timer {
                interval: 1000 // interval in milliseconds
                running: true // start the timer
                repeat: true // repeat the timer
                onTriggered: {
                    gpuload.text = statsbackend.getgpuload()
                    gpubarfill.height = gpuload.text * gpubar.height * 0.01
                    gpuload.text = gpuload.text +"%"
                }
            }
        }

        Rectangle {
            width: parent.width * 0.080
            height: parent.height * 0.8 * 0.2
            anchors.top: gpubar.bottom
            color: "transparent"
            anchors.left: parent.left
            anchors.leftMargin: parent.width * 0.035

            Text {
                //id: gpuload
                text: qsTr("GPU Load")
                color: "#FFFFFF"
                font.pixelSize: parent.width * 0.12
                anchors.centerIn: parent
            }
        }

        Rectangle {
            id: cpubar
            width: parent.width * 0.05
            height: parent.height * 0.7
            color: "#A0A0A0"
            anchors.top: parent.top
            anchors.topMargin: parent.height * 0.1
            anchors.left: gpubar.right
            anchors.leftMargin: parent.width * 0.05

            Rectangle {
                id: cpubarfill
                color: "steelblue"
                width: parent.width
                height: 0
                anchors.bottom: parent.bottom
            }

            Text {
                id: cpuload
                text: qsTr("0")
                color: "#F44336"
                font.pixelSize: parent.width * 0.20
                font.bold: true
                anchors.centerIn: parent
            }

            Timer {
                interval: 1000 // interval in milliseconds
                running: true // start the timer
                repeat: true // repeat the timer
                onTriggered: {
                    cpuload.text = statsbackend.getcpuload()
                    cpubarfill.height = cpuload.text * cpubar.height * 0.01
                    cpuload.text = cpuload.text + "%"
                }
            }
        }

        Rectangle {
            width: parent.width * 0.080
            height: parent.height * 0.8 * 0.2
            anchors.top: cpubar.bottom
            color: "transparent"
            anchors.left: parent.left
            anchors.leftMargin: parent.width * 0.135

            Text {
                text: qsTr("CPU Load")
                color: "#FFFFFF"
                font.pixelSize: parent.width * 0.12
                anchors.centerIn: parent
            }
        }

        Rectangle {
            id: ddrbar
            width: parent.width * 0.05
            height: parent.height * 0.7
            color: "#A0A0A0"
            anchors.top: parent.top
            anchors.topMargin: parent.height * 0.1
            anchors.left: cpubar.right
            anchors.leftMargin: parent.width * 0.05
            property int totalbw: statsbackend.getddrtotalbw()

            Rectangle {
                id: ddrbarfill
                color: "steelblue"
                width: parent.width
                height: 0
                anchors.bottom: parent.bottom
            }

            Rectangle {
                id: ddrwritebw
                color: "red"
                width: parent.width
                height: 0
                anchors.bottom: parent.bottom
            }

            Rectangle {
                id: ddrreadbw
                color: "yellow"
                width: parent.width
                height: 0
                anchors.bottom: ddrwritebw.top
            }

            Text {
                id: ddrload
                text: qsTr("0")
                color: "#F44336"
                font.pixelSize: parent.width * 0.20
                font.bold: true
                anchors.centerIn: parent
            }

            Text {
                text: qsTr("MB/S")
                color: "#F44336"
                font.pixelSize: parent.width * 0.2
                anchors.horizontalCenter: parent.horizontalCenter
                font.bold: true
                anchors.top: ddrload.bottom
            }

            Timer {
                interval: 1000 // interval in milliseconds
                running: true // start the timer
                repeat: true // repeat the timer

                onTriggered: {
                    ddrload.text = statsbackend.getddrload()
                    readbw.text = statsbackend.getddrreadbw()
                    writebw.text = statsbackend.getddrwritebw()
                    ddrreadbw.height = (readbw.text * ddrbar.height) /ddrbar.totalbw
                    ddrwritebw.height = (writebw.text * ddrbar.height) /ddrbar.totalbw
                }
            }
        }

        Text {
            anchors.left: ddrbar.right
            anchors.leftMargin: parent.width * 0.005
            anchors.right: writebwlegend.left
            anchors.verticalCenter: writebwlegend.verticalCenter
            text: "WR_BW"
            color: "red"
            font.pixelSize: anchors.width * 0.2
        }

        Rectangle {
            id: writebwlegend
            height: parent.height * 0.2
            width: height * 1.5
            anchors.left: ddrbar.right
            anchors.bottom: ddrbar.bottom
            anchors.leftMargin: parent.width * 0.04
            color: "red"

            Text{
                id: writebw
                text: qsTr("0")
                color: "black"
                anchors.centerIn: parent
                font.pixelSize: parent.width * 0.3
            }
        }

        Text {
            anchors.left: ddrbar.right
            anchors.leftMargin: parent.width * 0.005
            anchors.right: readbwlegend.left
            anchors.verticalCenter: readbwlegend.verticalCenter
            text: "RD_BW"
            color: "yellow"
            font.pixelSize: anchors.width * 0.2
        }

        Rectangle {
            id: readbwlegend
            height: writebwlegend.height
            width: writebwlegend.width
            anchors.left: writebwlegend.left
            anchors.bottom: writebwlegend.top
            anchors.bottomMargin: parent.height * 0.1
            color: "yellow"

            Text{
                id: readbw
                text: qsTr("0")
                color: "black"
                anchors.centerIn: parent
                font.pixelSize: parent.width * 0.3
            }
        }

        Rectangle {
            width: parent.width * 0.080
            height: parent.height * 0.8 * 0.2
            anchors.top: ddrbar.bottom
            color: "transparent"
            anchors.horizontalCenter: ddrbar.horizontalCenter

            Text {
                text: qsTr("DDR Load")
                color: "#FFFFFF"
                font.pixelSize: parent.width * 0.12
                anchors.centerIn: parent
            }
        }

        Rectangle {
            id: tempbar
            width: parent.width * 0.05
            height: parent.height * 0.7
            color: "#A0A0A0"
            anchors.top: parent.top
            anchors.topMargin: parent.height * 0.1
            anchors.left: readbwlegend.right
            anchors.leftMargin: parent.width * 0.05

            Rectangle {
                id: tempbarvalue
                width: parent.width
                height: 0
                anchors.bottom: parent.bottom
                clip: true

                Rectangle {
                    id: tempbarfill
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    height: tempbar.height
                    width: tempbar.width

                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "red" }
                        GradientStop { position: 0.33; color: "yellow" }
                        GradientStop { position: 1.0; color: "green" }
                    }
                }
            }

            Text {
                id: temperature
                text: qsTr("0")
                color: "#F44336"
                font.pixelSize: parent.width * 0.20
                font.bold: true
                anchors.centerIn: parent
            }

            Timer {
                interval: 1000 // interval in milliseconds
                running: true // start the timer
                repeat: true // repeat the timer
                onTriggered: {
                    temperature.text = statsbackend.get_soc_temp()
                    tempbarvalue.height = temperature.text * tempbar.height / 150
                    temperature.text = temperature.text + " °C"
                }
            }
        }

        Rectangle {
            width: parent.width * 0.080
            height: parent.height * 0.8 * 0.2
            anchors.top: tempbar.bottom
            color: "transparent"
            anchors.horizontalCenter: tempbar.horizontalCenter

            Text {
                text: qsTr("SoC Temperature")
                color: "#FFFFFF"
                font.pixelSize: parent.width * 0.12
                anchors.centerIn: parent
            }
        }
    }
}

