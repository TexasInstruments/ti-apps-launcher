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
        color: "#ffebcd"
        Image {
            id: backgroundimage
            source:"file://home/root/jacinto_oob_demo_home_image.png"
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
                        gpuperformance.gpuload0()
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
                        gpuperformance.gpuload1()
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
                        gpuperformance.gpuload2()
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
                        gpuperformance.gpuload3()
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
                        gpuperformance.gpuload4()
                        timer.running = false
                        timer.running = true
                    }
                }
            }
        }
        Rectangle {
            width: levelbar.width
            height: levelbar.height * 0.4 * 0.35
            anchors.bottom: levelbar.top
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
            id: benchmarksname
            width: parent.width  * 0.1
            height: levelbar.height * 0.8
            anchors.right: levelbar.left
            anchors.top: levelbar.top
            color: "#fff5ee"
            Rectangle{
                id: level1benchmark
                width: parent.width
                height: parent.height * 0.25
                anchors.bottom: parent.bottom
                color: "transparent"
                Text {
                    text: qsTr("Buffer")
                    color: "#F44336"
                    font.pixelSize: parent.width * 0.1
                    anchors.centerIn: parent
                }
            }
            Rectangle{
                id: level2benchmark
                width: parent.width
                height: parent.height * 0.25
                anchors.bottom: level1benchmark.top
                color: "transparent"
                Text {
                    text: qsTr("Ideas")
                    color: "#F44336"
                    font.pixelSize: parent.width * 0.1
                    anchors.centerIn: parent
                }
            }
            Rectangle{
                id: level3benchmark
                width: parent.width
                height: parent.height * 0.25
                anchors.bottom: level2benchmark.top
                color: "transparent"
                Text {
                    text: qsTr("Texture")
                    color: "#F44336"
                    font.pixelSize: parent.width * 0.1
                    anchors.centerIn: parent
                }
            }
            Rectangle{
                id: level4benchmark
                width: parent.width
                height: parent.height * 0.25
                anchors.bottom: level3benchmark.top
                color: "transparent"
                Text {
                    text: qsTr("Terrain")
                    color: "#F44336"
                    font.pixelSize: parent.width * 0.1
                    anchors.centerIn: parent
                }
            }
        }
        Rectangle {
            width: benchmarksname.width
            height: benchmarksname.height * 0.4 * 0.35
            anchors.bottom: benchmarksname.top
            anchors.right: benchmarksname.right
            color: "transparent"
            Text {
                text: qsTr("Benchmarks")
                color: "#FFFFFF"
                font.pixelSize: parent.width * 0.15
                font.bold: true
                anchors.centerIn: parent
            }
        }
        Rectangle {
            id: perfstats
            height: parent.height * 0.25
            width: parent.width * 0.2
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            border.color: "black"
            border.width: 5
            Rectangle {
                id: headtitle
                width: parent.width
                height: parent.height * 0.33
                border.color: "black"
                border.width: 2.5
                color: "transparent"
                Text {
                    id: title
                    text: "glmark2"
                    color: "black"
                    anchors.centerIn: parent
                    font.pixelSize: parent.width * 0.1
                    font.bold: true
                }
            }
            Rectangle {
                id: index10
                width: parent.width * 0.49
                height: parent.height * 0.33
                anchors.top: headtitle.bottom
                anchors.left: parent.left
                border.color: "black"
                border.width: 2.5
                color: "transparent"
                Text {
                    id: fpstext
                    text: "FPS:"
                    color: "black"
                    anchors.centerIn: parent
                    font.pixelSize: parent.width * 0.2 
                }
            }
            Rectangle {
                id: index11
                height: parent.height * 0.33
                anchors.top: headtitle.bottom
                anchors.left: index10.right
                anchors.right: headtitle.right
                border.color: "black"
                border.width: 2.5
                color: "transparent"
                Text {
                    id:fps
                    text: "Please click to run"
                    color: "red"
                    font.pixelSize: parent.width * 0.1
                    anchors.centerIn: parent
                }
            }
            Rectangle {
                id: index20
                width: parent.width * 0.49
                height: parent.height * 0.33
                anchors.top: index10.bottom
                anchors.left: index10.left
                border.color: "black"
                border.width: 2.5
                color: "transparent"
                Text {
                    id: scoretext
                    text: " Score: "
                    font.pixelSize: parent.width * 0.2
                    color: "black"
                    anchors.centerIn: parent
                }
            }
            Rectangle {
                id: index21
                height: parent.height * 0.33
                anchors.top: index11.bottom
                anchors.left: index11.left
                anchors.right: headtitle.right
                border.color: "black"
                border.width: 2.5
                color: "transparent"
                Text {
                    id: score
                    text: "Please click to run"
                    color: "red"
                    font.pixelSize: parent.width * 0.1
                    anchors.centerIn: parent
                }
            }
            Timer {
                id: timer
                interval: 102000
                running: false
                repeat: false
                onTriggered: {
                    fps.font.pixelSize = index11.width * 0.2
                    score.font.pixelSize = index21.width * 0.2
                    fps.text = gpuperformance.getfps()
                    score.text = gpuperformance.getscore()
                }
            }
        }
    }
}
