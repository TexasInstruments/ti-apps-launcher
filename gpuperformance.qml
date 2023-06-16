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
    width: 1584
    height: 648
  
    Rectangle {
        id: backgroundrect
        width: parent.width
        height: parent.height
        
        Image {
            id: backgroundimage
            source:"images/Background.png"
            width: parent.width
            height: parent.height
        }
        //Slider {
        //    id: slider2
        //    orientation: Qt.Vertical
        //    from: 0
        //    to: 100
        //    value: 0
        //    stepSize: 1
        //    anchors.right: parent.right
        //    anchors.rightMargin: parent.width * 0.05
        //    anchors.verticalCenter: parent.verticalCenter
        //    //visible:false
        //    //width: parent.width * 0.6
        //    onValueChanged: {
        //        if (value < 20) {
        //        //    gpulevel.text = qsTr("0")
        //            gpuperfbackend.gpuload0()
        //        }
        //        else if (value < 40) {
        //            gpuperfbackend.gpuload1()
        //        }
        //        else if (value < 60) {
        //            gpuperfbackend.gpuload2()
        //        }
        //        else if (value < 80) {
        //            gpuperfbackend.gpuload3()
        //        }
        //        else {
        //            gpuperfbackend.gpuload4()
        //        }
        //    }
        //}
        Rectangle {
            id: levelbar
            height: parent.height * 0.5
            width: parent.width * 0.05
            anchors.right: parent.right
            anchors.rightMargin: parent.width * 0.1
            anchors.verticalCenter: parent.verticalCenter
            color: "orange"
            Rectangle {
                id: level0
                height: parent.height * 0.2
                width: parent.width
                anchors.bottom: parent.bottom
                color: "transparent"
                Text {
                    text: qsTr("0")
                    color: "#F44336"
                    font.pixelSize: parent.width * 0.40
                    anchors.centerIn: parent
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        level0.color = "#FFFFFF"
                        level1.color = "orange"
                        level2.color = "orange"
                        level3.color = "orange"
                        level4.color = "orange"
                        gpuperfbackend.gpuload0()
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
                        level0.color = "orange"
                        level1.color = "#FFFFFF"
                        level2.color = "orange"
                        level3.color = "orange"
                        level4.color = "orange"
                        gpuperfbackend.gpuload1()
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
                        level0.color = "orange"
                        level1.color = "orange"
                        level2.color = "#FFFFFF"
                        level3.color = "orange"
                        level4.color = "orange"
                        
                        gpuperfbackend.gpuload2()
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
                        level0.color = "orange"
                        level1.color = "orange"
                        level2.color = "orange"
                        level3.color = "#FFFFFF"
                        level4.color = "orange"
                        gpuperfbackend.gpuload3()
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
                        level0.color = "orange"
                        level1.color = "orange"
                        level2.color = "orange"
                        level3.color = "orange"
                        level4.color = "#FFFFFF"
                        gpuperfbackend.gpuload4()
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
    }
}