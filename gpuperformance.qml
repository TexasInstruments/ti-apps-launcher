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
        //            backend.gpuload0()
        //        }
        //        else if (value < 40) {
        //            backend.gpuload1()
        //        }
        //        else if (value < 60) {
        //            backend.gpuload2()
        //        }
        //        else if (value < 80) {
        //            backend.gpuload3()
        //        }
        //        else {
        //            backend.gpuload4()
        //        }
        //    }
        //}
        Rectangle {
            height: parent.height * 0.7
            width: parent.width * 0.07
            anchors.right: parent.right
            anchors.rightMargin: parent.width * 0.1
            anchors.verticalCenter: parent.verticalCenter
            Rectangle {
                id: level0
                height: parent.height * 0.2
                width: parent.width
                anchors.bottom: parent.bottom
                color: "#A0A0A0"
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
                        level1.color = "#A0A0A0"
                        level2.color = "#A0A0A0"
                        level3.color = "#A0A0A0"
                        level4.color = "#A0A0A0"
                        backend.gpuload0()
                    }
                }
            }
            Rectangle {
                id: level1
                height: parent.height * 0.2
                width: parent.width
                anchors.bottom: level0.top
                color: "#A0A0A0"
                Text {
                    text: qsTr("1")
                    color: "#F44336"
                    font.pixelSize: parent.width * 0.40
                    anchors.centerIn: parent
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        level0.color = "#A0A0A0"
                        level1.color = "#FFFFFF"
                        level2.color = "#A0A0A0"
                        level3.color = "#A0A0A0"
                        level4.color = "#A0A0A0"
                        backend.gpuload1()
                    }
                }
            }
            Rectangle {
                id: level2
                height: parent.height * 0.2
                width: parent.width
                anchors.bottom: level1.top
                color: "#A0A0A0"
                Text {
                    text: qsTr("2")
                    color: "#F44336"
                    font.pixelSize: parent.width * 0.40
                    anchors.centerIn: parent
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        level0.color = "#A0A0A0"
                        level1.color = "#A0A0A0"
                        level2.color = "#FFFFFF"
                        level3.color = "#A0A0A0"
                        level4.color = "#A0A0A0"
                        backend.gpuload2()
                    }
                }
            }
            Rectangle {
                id: level3
                height: parent.height * 0.2
                width: parent.width
                anchors.bottom: level2.top
                color: "#A0A0A0"
                Text {
                    text: qsTr("3")
                    color: "#F44336"
                    font.pixelSize: parent.width * 0.40
                    anchors.centerIn: parent
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        level0.color = "#A0A0A0"
                        level1.color = "#A0A0A0"
                        level2.color = "#A0A0A0"
                        level3.color = "#FFFFFF"
                        level4.color = "#A0A0A0"
                        backend.gpuload3()
                    }
                }
            }
            Rectangle {
                id: level4
                height: parent.height * 0.2
                width: parent.width
                anchors.bottom: level3.top
                color: "#A0A0A0"
                Text {
                    text: qsTr("4")
                    color: "#F44336"
                    font.pixelSize: parent.width * 0.40
                    anchors.centerIn: parent
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        level0.color = "#A0A0A0"
                        level1.color = "#A0A0A0"
                        level2.color = "#A0A0A0"
                        level3.color = "#A0A0A0"
                        level4.color = "#FFFFFF"
                        backend.gpuload4()
                    }
                }
            }
        }

    }
}