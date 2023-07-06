import QtQml 2.1
import QtQuick 2.14
import QtMultimedia 5.1
import QtQuick.Window 2.14
import QtQuick.Controls 2.1
import QtGraphicalEffects 1.12
import Qt.labs.folderlistmodel 2.4

import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtQuick.Layouts 1.3
Rectangle {
    id: button2window
    visible: true
    height: Screen.desktopAvailableHeight * 0.6
    width: Screen.desktopAvailableWidth * 0.825
    color: "#344045"
    Rectangle{
        id: gpu_benchmarks
        height: parent.height * 0.25
        width: parent.width * 0.3
        anchors.left: parent.left
        anchors.leftMargin: parent.width * 0.1
        anchors.verticalCenter: parent.verticalCenter
        border.color: "black"
        border.width: 5
        Rectangle{
            id:title_gpubenchmark
            width: parent.width
            height: parent.height * 0.33
            anchors.top: parent.top
            color: "transparent"
            border.color: "black"
            border.width: 2.5
            Text {
                text: qsTr("GPU Benchmarks")
                color: "black"
                font.pixelSize: parent.width * 0.08
                font.bold: true
                anchors.centerIn: parent
            }
        }
        Rectangle {
            id: gpu_benchmark1
            width: parent.width * 0.25
            anchors.left: parent.left
            anchors.top: title_gpubenchmark.bottom
            anchors.bottom: parent.bottom
            color: "transparent"
            border.color: "black"
            border.width: 2.5
            Text {
                text: qsTr("glmark2")
                color: "#F44336"
                font.pixelSize: parent.width * 0.15
                font.bold: true
                anchors.centerIn: parent
            }
        }
        Rectangle {
            id: index11
            width: parent.width * 0.25
            height: gpu_benchmark1.height * 0.5
            anchors.top: title_gpubenchmark.bottom
            anchors.left: gpu_benchmark1.right
            color: "transparent"
            border.color: "black"
            border.width: 2.5
            Text {
                id: fpstext
                text: qsTr("FPS")
                color: "black"
                font.pixelSize: parent.width * 0.15
                anchors.centerIn: parent
            }
        }
        Rectangle {
            id: index12
            width: parent.width * 0.25
            height: index11.height
            anchors.left: index11.right
            anchors.top: index11.top
            color: "transparent"
            border.color: "black"
            border.width: 2.5
            Text {
                id: index12text
                text: qsTr("click")
                color: "#F44336"
                font.pixelSize: parent.width * 0.17
                anchors.centerIn: parent
            }
        }
        Rectangle {
            id: index21
            width: index11.width
            height: index11.height
            anchors.left: index11.left
            anchors.top: index11.bottom
            color: "transparent"
            border.color: "black"
            border.width: 2.5
            Text {
                id: scoretext
                text: qsTr("Score")
                color: "black"
                font.pixelSize: parent.width * 0.15
                anchors.centerIn: parent
            }
        }
        Rectangle {
            id: index22
            width: index12.width
            height: index12.height
            anchors.left: index12.left
            anchors.top: index12.bottom
            color: "transparent"
            border.color: "black"
            border.width: 2.5
            Text {
                id: index22text
                text: qsTr("click")
                color: "#F44336"
                font.pixelSize: parent.width * 0.17
                anchors.centerIn: parent
            }
        }
        Rectangle{
            id: glmark2playbutton
            width: parent.width * 0.25
            height: gpu_benchmark1.height
            anchors.left: index12.right
            anchors.top: title_gpubenchmark.bottom
            color: "transparent"
            border.color: "black"
            border.width: 2.5
            Image {
                id: playbutton1
                width: systemplaybutton1.width
                height: width
                source: "../images/playbutton.png"
                anchors.centerIn: parent
                property int flag1: 0
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if(playbutton1.flag1 == 0) {
                            benchmarks.playbutton1pressed()
                            playbutton1.flag1 = 1
                            playbutton1timer.running = true
                            playbutton1.source = "../images/stop-button.png"
                        }
                        else {
                            benchmarks.playbutton1pressedagain()
                            if(benchmarks.islogavl()) {
                                index12text.text = benchmarks.playbutton1fps()
                                index22text.text = benchmarks.playbutton1score()
                            }
                            else {
                                index12text.text = "-"
                                index22text.text = "-"
                            }
                            playbutton1.flag1 = 0
                            playbutton1timer.running = false
                            playbutton1.source = "../images/playbutton.png"
                        }
                    }
                }
            }
            Timer {
                id: playbutton1timer
                interval: 11000
                running: false
                repeat: false
                onTriggered: {
                    playbutton1.flag1 = 0
                    benchmarks.playedcompletely()
                    index12text.text = benchmarks.playbutton1fps()
                    index22text.text = benchmarks.playbutton1score()
                    playbutton1.source = "../images/playbutton.png"
                }
            }
        }
    }
    Rectangle {
        id: system_benchmarks
        width: gpu_benchmarks.width
        height: parent.height * 0.5
        anchors.right: parent.right
        anchors.rightMargin: parent.width * 0.1
        anchors.verticalCenter: parent.verticalCenter
        border.color: "black"
        border.width: 5
        Rectangle {
            id: title_systembenchmark
            width: parent.width
            height: parent.height * 0.2
            anchors.top: parent.top
            color: "transparent"
            border.color: "black"
            border.width: 2.5
            Text {
                text: qsTr("System Benchmarks")
                color: "black"
                font.pixelSize: parent.width * 0.08
                font.bold: true
                anchors.centerIn: parent
            }
        }
        Rectangle {
            id: systemindex10
            height: parent.height * 0.16
            width: parent.width * 0.5
            anchors.left: parent.left
            anchors.top: title_systembenchmark.bottom
            color: "transparent"
            border.color: "black"
            border.width: 2.5
            Text {
                text: qsTr("dhrystone")
                color: "#F44336"
                font.pixelSize: parent.width * 0.075
                font.bold: true
                anchors.centerIn: parent
            }
        }
        Rectangle {
            id: systemindex11
            height: parent.height * 0.16
            width : parent.width * 0.5
            anchors.left: systemindex10.right
            anchors.top: systemindex10.top
            color: "transparent"
            border.color: "black"
            border.width: 2.5
            Image {
                id: systemplaybutton1
                height: parent.height * 0.8
                width: height
                source: "../images/playbutton.png"
                anchors.centerIn: parent
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        benchmarks.systemplaybutton1pressed()
                    }
                }
            }
        }
        Rectangle {
            id: systemindex20
            height: parent.height * 0.16
            width: parent.width * 0.5
            anchors.left: parent.left
            anchors.top: systemindex10.bottom
            color: "transparent"
            border.color: "black"
            border.width: 2.5
            Text {
                text: qsTr("linpack")
                color: "#F44336"
                font.pixelSize: parent.width * 0.075
                font.bold: true
                anchors.centerIn: parent
            }
        }
        Rectangle {
            id: systemindex21
            height: parent.height * 0.16
            width : parent.width * 0.5
            anchors.left: systemindex20.right
            anchors.top: systemindex20.top
            color: "transparent"
            border.color: "black"
            border.width: 2.5
            Image {
                id: systemplaybutton2
                height: parent.height * 0.8
                width: height
                source: "../images/playbutton.png"
                anchors.centerIn: parent
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        benchmarks.systemplaybutton2pressed()
                    }
                }
            }
        }
        Rectangle {
            id: systemindex30
            height: parent.height * 0.16
            width: parent.width * 0.5
            anchors.left: parent.left
            anchors.top: systemindex20.bottom
            color: "transparent"
            border.color: "black"
            border.width: 2.5
            Text {
                text: qsTr("nbench")
                color: "#F44336"
                font.pixelSize: parent.width * 0.075
                font.bold: true
                anchors.centerIn: parent
            }
        }
        Rectangle {
            id: systemindex31
            height: parent.height * 0.16
            width : parent.width * 0.5
            anchors.left: systemindex30.right
            anchors.top: systemindex30.top
            color: "transparent"
            border.color: "black"
            border.width: 2.5
            Image {
                id: systemplaybutton3
                height: parent.height * 0.8
                width: height
                source: "../images/playbutton.png"
                anchors.centerIn: parent
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        benchmarks.systemplaybutton3pressed()
                    }
                }
            }
        }
        Rectangle {
            id: systemindex40
            height: parent.height * 0.16
            width: parent.width * 0.5
            anchors.left: parent.left
            anchors.top: systemindex30.bottom
            color: "transparent"
            border.color: "black"
            border.width: 2.5
            Text {
                text: qsTr("stream")
                color: "#F44336"
                font.pixelSize: parent.width * 0.075
                font.bold: true
                anchors.centerIn: parent
            }
        }
        Rectangle {
            id: systemindex41
            height: parent.height * 0.16
            width : parent.width * 0.5
            anchors.left: systemindex40.right
            anchors.top: systemindex40.top
            color: "transparent"
            border.color: "black"
            border.width: 2.5
            Image {
                id: systemplaybutton4
                height: parent.height * 0.8
                width: height
                source: "../images/playbutton.png"
                anchors.centerIn: parent
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        benchmarks.systemplaybutton4pressed()
                    }
                }
            }
        }
        Rectangle {
            id: systemindex50
            height: parent.height * 0.16
            width: parent.width * 0.5
            anchors.left: parent.left
            anchors.top: systemindex40.bottom
            color: "transparent"
            border.color: "black"
            border.width: 2.5
            Text {
                text: qsTr("whetstone")
                color: "#F44336"
                font.pixelSize: parent.width * 0.075
                font.bold: true
                anchors.centerIn: parent
            }
        }
        Rectangle {
            id: systemindex51
            height: parent.height * 0.16
            width : parent.width * 0.5
            anchors.left: systemindex50.right
            anchors.top: systemindex50.top
            color: "transparent"
            border.color: "black"
            border.width: 2.5
            Image {
                id: systemplaybutton5
                height: parent.height * 0.8
                width: height
                source: "../images/playbutton.png"
                anchors.centerIn: parent
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        benchmarks.systemplaybutton5pressed()
                    }
                }
            }
        }
    }

    Rectangle {
        id: linkstarter
        height: parent.height * 0.05
        width: parent.width * 0.2
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        color: "transparent"
        Text {
            id: info1
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: parent.width * 0.05
            text: "For SDK performance data sheet: click "
            color: "black"
        }
        Text {
            anchors.left: info1.right
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: parent.width * 0.05
            text: "<font color=\"blue\">here</font>"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    firefox_browser2.launch_or_stop()
                }
            }
        }
    }
    

}   

    
