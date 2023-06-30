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
    id: gpuperformancewindow
    visible: true
    height: Screen.desktopAvailableHeight * 0.6
    width: Screen.desktopAvailableWidth * 0.825
  
    Rectangle {
        id: backgroundrect
        width: parent.width
        height: parent.height
        
        Image {
            id: backgroundimage
            source:"../images/Background.png"
            width: parent.width
            height: parent.height
        }
        Rectangle {
            id: levelbar
            height: parent.height * 0.5
            width: parent.width * 0.05
            anchors.right: parent.right
            anchors.rightMargin: parent.width * 0.1
            anchors.verticalCenter: parent.verticalCenter
            color: "gray"
            Rectangle {
                id: level0
                height: parent.height * 0.2
                width: parent.width
                anchors.bottom: parent.bottom
                color: "green"
                Text {
                    text: qsTr("0")
                    color: "#F44336"
                    font.pixelSize: parent.width * 0.40
                    anchors.centerIn: parent
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        level0.color = "green"
                        level1.color = "transparent"
                        level2.color = "transparent"
                        level3.color = "transparent"
                        level4.color = "transparent"
                        gpuperfbackend.gpuload0()
                        timer.running = false
                    }
                }
            }
            Rectangle {
                id: level1
                height: parent.height * 0.2
                width: parent.width
                anchors.bottom: level0.top
                color: "transparent"
                Text {
                    text: qsTr("1")
                    color: "#F44336"
                    font.pixelSize: parent.width * 0.40
                    anchors.centerIn: parent
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        level0.color = "green"
                        level1.color = "#90EE90"
                        level2.color = "transparent"
                        level3.color = "transparent"
                        level4.color = "transparent"
                        gpuperfbackend.gpuload1()
                        timer.running = false
                        timer.running = true
                    }
                }
            }
            Rectangle {
                id: level2
                height: parent.height * 0.2
                width: parent.width
                anchors.bottom: level1.top
                color: "transparent"
                Text {
                    text: qsTr("2")
                    color: "#F44336"
                    font.pixelSize: parent.width * 0.40
                    anchors.centerIn: parent
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        level0.color = "green"
                        level1.color = "#90EE90"
                        level2.color = "yellow"
                        level3.color = "transparent"
                        level4.color = "transparent"
                        gpuperfbackend.gpuload2()
                        timer.running = false
                        timer.running = true
                    }
                }
            }
            Rectangle {
                id: level3
                height: parent.height * 0.2
                width: parent.width
                anchors.bottom: level2.top
                color: "transparent"
                Text {
                    text: qsTr("3")
                    color: "#F44336"
                    font.pixelSize: parent.width * 0.40
                    anchors.centerIn: parent
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        level0.color = "green"
                        level1.color = "#90EE90"
                        level2.color = "yellow"
                        level3.color = "orange"
                        level4.color = "transparent"
                        gpuperfbackend.gpuload3()
                        timer.running = false
                        timer.running = true
                    }
                }
            }
            Rectangle {
                id: level4
                height: parent.height * 0.2
                width: parent.width
                anchors.bottom: level3.top
                color: "transparent"
                Text {
                    text: qsTr("4")
                    color: "#F44336"
                    font.pixelSize: parent.width * 0.40
                    anchors.centerIn: parent
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        level0.color = "green"
                        level1.color = "#90EE90"
                        level2.color = "yellow"
                        level3.color = "orange"
                        level4.color = "red"
                        gpuperfbackend.gpuload4()
                        timer.running = false
                        timer.running = true
                    }
                }
            }
        }
        Rectangle {
            width: levelbar.width
            height: levelbar.height * 0.4 * 0.35
            anchors.top: levelbar.bottom
            anchors.right: parent.right
            anchors.rightMargin: parent.width * 0.1
            color: "transparent"
            Text {
                text: qsTr("GPU Load\nLevels")
                color: "#FFFFFF"
                font.pixelSize: parent.width * 0.2
                font.bold: true
                anchors.centerIn: parent
            }
        }
        Rectangle {
            id: perfstats
            width: parent.width * 0.3
            height: parent.height * 0.1
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            Text {
                id:lefttext
                text: qsTr("gl mark2: FPS= ")
                color: "black"
                font.pixelSize: parent.width * 0.05
                anchors.left: parent.left
            }
            Text {
                id:fps
                text: "1418"
                color: "black"
                font.pixelSize: parent.width * 0.05
                anchors.left: lefttext.right
            }
            Text {
                id: scoretext
                text: " Score: "
                anchors.left: fps.right
                font.pixelSize: parent.width * 0.05
            }
            Text {
                id: score
                text: "712"
                color: "black"
                font.pixelSize: parent.width * 0.05
                anchors.left: scoretext.right
            }
            Timer {
                id: timer
                interval: 102000
                running: false
                repeat: false
                onTriggered: {
                    fps.text = gpuperfbackend.getfps()
                    score.text = gpuperfbackend.getscore()
                }
            }
        }
    }
}
