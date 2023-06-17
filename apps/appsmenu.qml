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
    width: parent.width
    height: parent.height
    color: "#17252A"
    Rectangle {
        id: leftSubMenu

        width: parent.width * 0.9
        height: parent.height * 0.6
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        color: "#344045"

        border.color: "#DEF2F1"
        border.width: 1
        radius: 10

        ColumnLayout {
            anchors.fill: parent

            Repeater {
                model: appsmenu.button_getcount()

                Button {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 50
                    text: appsmenu.button_getname(index)
                    onClicked: appWindow.source = appsmenu.button_getqml(index)
                }
            }
        }
    }
}
/*
        CheckBox {
            text: "Industrial Control"
            font.bold: true
            font.pointSize: 13
            height: parent.height * 0.1
            width: parent.width * 0.85
            anchors.top: parent.top
            anchors.topMargin: parent.height * 0.04
            anchors.horizontalCenter: parent.horizontalCenter
            indicator: Rectangle {}
background: Rectangle {
id: leftMenuButton1BG
        color: !parent.enabled ? "#17252A" : (parent.hovered ? "#84CDC9" : (parent.checkState===Qt.Checked? "#2B837F" : "#3AAFA9"))
        border.color: "#DEF2F1"
        border.width: 1
        radius: 10
            }
onCheckStateChanged: {
                         if (leftMenuButton1.checked) {
                                 appWindow.source = "industrial_control.qml"
                         } else {
                                 appWindow.source = ""
                         }
                     }
        }

            CheckBox {
id: leftMenuButton2
        text: "Camera Recorder"
        font.bold: true
        font.pointSize: 13
        height: parent.height * 0.1
        width: parent.width * 0.85
        anchors.top: leftMenuButton1.bottom
        anchors.topMargin: parent.height * 0.04
        anchors.horizontalCenter: parent.horizontalCenter
        indicator: Rectangle {}
background: Rectangle {
id: leftMenuButton2BG
        color: !parent.enabled ? "#17252A" : (parent.hovered ? "#84CDC9" : (parent.checkState===Qt.Checked? "#2B837F" : "#3AAFA9"))
        border.color: "#DEF2F1"
        border.width: 1
        radius: 10
            }
onCheckStateChanged: {
                         if (leftMenuButton2.checked) {

                             leftMenuButton1.enabled = false
                                 //   leftMenuButton2.enabled = false
                                 leftMenuButton3.enabled = false
                                 leftMenuButton4.enabled = false
                                 leftMenuButton5.enabled = false
                                 leftMenuButton6.enabled = false
                                 leftMenuButton7.enabled = false

                                 appWindow.source = "camera_recorder.qml"
                                 camrecbackend.playcam()
                         } else {
                             mediaplayer1.source = " "
                                 leftMenuButton1.enabled = true
                                 //   leftMenuButton2.enabled = true
                                 leftMenuButton3.enabled = true
                                 leftMenuButton4.enabled = true
                                 leftMenuButton5.enabled = true
                                 leftMenuButton6.enabled = true
                                 leftMenuButton7.enabled = true

                                 //  videoOutput.visibile = false
                                 //  recordbutton.visible = false
                                 camrecbackend.stopcam();
                             appWindow.source = ""

                         }
                     }
            }
            CheckBox {
id: leftMenuButton3
                    text: "Benchmarks"
                    font.bold: true
                    font.pointSize: 13
                    height: parent.height * 0.1
                    width: parent.width * 0.85
                    anchors.top: leftMenuButton2.bottom
                    anchors.topMargin: parent.height * 0.04
                    anchors.horizontalCenter: parent.horizontalCenter
                    indicator: Rectangle {}
                    background: Rectangle {
                        id: leftMenuButton3BG
                        color: !parent.enabled ? "#17252A" : (parent.hovered ? "#84CDC9" : (parent.checkState===Qt.Checked? "#2B837F" : "#3AAFA9"))
                        border.color: "#DEF2F1"
                        border.width: 1
                        radius: 10
                    }
                    onCheckStateChanged: {
                        if (leftMenuButton3.checked) {
                            leftMenuButton1.enabled = false
                            leftMenuButton2.enabled = false
                          //  leftMenuButton3.enabled = false
                            leftMenuButton4.enabled = false
                            leftMenuButton5.enabled = false
                            leftMenuButton6.enabled = false
                            leftMenuButton7.enabled = false
                            appWindow.source = "benchmarks.qml"
                        } else {
                            mediaplayer1.source = " "
                            leftMenuButton1.enabled = true
                            leftMenuButton2.enabled = true
                          //  leftMenuButton3.enabled = true
                            leftMenuButton4.enabled = true
                            leftMenuButton5.enabled = true
                            leftMenuButton6.enabled = true
                            leftMenuButton7.enabled = true

                            //benchmarkswindow.visible = false
                            appWindow.source = ""
                            benchmarksbackend.playbutton1pressedagain()
                        }
                    }
                }
                CheckBox {
                    id: leftMenuButton4
                    text: "GPU Performance"
                    font.bold: true
                    font.pointSize: 13
                    height: parent.height * 0.1
                    width: parent.width * 0.85
                    anchors.top: leftMenuButton3.bottom
                    anchors.topMargin: parent.height * 0.04
                    anchors.horizontalCenter: parent.horizontalCenter
                    indicator: Rectangle {}
                    background: Rectangle {
                        id: leftMenuButton4BG
                        color: !parent.enabled ? "#17252A" : (parent.hovered ? "#84CDC9" : (parent.checkState===Qt.Checked? "#2B837F" : "#3AAFA9"))
                        border.color: "#DEF2F1"
                        border.width: 1
                        radius: 10
                    }
                    onCheckStateChanged: {
                        if (leftMenuButton4.checked) {
                        
                            leftMenuButton1.enabled = false
                            leftMenuButton2.enabled = false
                            leftMenuButton3.enabled = false
                        //    leftMenuButton4.enabled = false
                            leftMenuButton5.enabled = false
                            leftMenuButton6.enabled = false
                            leftMenuButton7.enabled = false


                            //slider2.visible = true
                            appWindow.source = "gpu_performance.qml"

                        } else {
                            mediaplayer1.source = " "
                            leftMenuButton1.enabled = true
                            leftMenuButton2.enabled = true
                            leftMenuButton3.enabled = true
                          //  leftMenuButton4.enabled = true
                            leftMenuButton5.enabled = true
                            leftMenuButton6.enabled = true
                            leftMenuButton7.enabled = true

                        
                            //slider2.visible = false
                            appWindow.source = ""
                            gpuperfbackend.gpuload0()
                        }
                    }
                }
                CheckBox {
                    id: leftMenuButton5
                    text: "Multi Cam"
                    font.bold: true
                    font.pointSize: 13
                    height: parent.height * 0.1
                    width: parent.width * 0.85
                    anchors.top: leftMenuButton4.bottom
                    anchors.topMargin: parent.height * 0.04
                    anchors.horizontalCenter: parent.horizontalCenter
                    indicator: Rectangle {}
                    background: Rectangle {
                        id: leftMenuButton5BG
                        color: !parent.enabled ? "#17252A" : (parent.hovered ? "#84CDC9" : (parent.checkState===Qt.Checked? "#2B837F" : "#3AAFA9"))
                        border.color: "#DEF2F1"
                        border.width: 1
                        radius: 10
                    }
                    onCheckStateChanged: {
                        if (leftMenuButton5.checked) {
                            mediaplayer1.source = backend.leftMenuButtonPressed(3, leftMenu.width + (alignVideo.border.width * 2), topBar.height + ((appWindow.height - alignVideo.height)/2) + (alignVideo.border.width * 2), videooutput.width, videooutput.height)
                            leftMenuButton1.enabled = false
                            leftMenuButton2.enabled = false
                            leftMenuButton3.enabled = false
                            leftMenuButton4.enabled = false
                          //  leftMenuButton5.enabled = false
                            leftMenuButton6.enabled = false
                            leftMenuButton7.enabled = false
                        } else {
                            mediaplayer1.source = " "
                            leftMenuButton1.enabled = true
                            leftMenuButton2.enabled = true
                            leftMenuButton3.enabled = true
                            leftMenuButton4.enabled = true
                          //  leftMenuButton5.enabled = true
                            leftMenuButton6.enabled = true
                            leftMenuButton7.enabled = true
                        }
                    }
                }
                CheckBox {
                    id: leftMenuButton6
                    text: "Multi Display"
                    font.bold: true
                    font.pointSize: 13
                    height: parent.height * 0.1
                    width: parent.width * 0.85
                    anchors.top: leftMenuButton5.bottom
                    anchors.topMargin: parent.height * 0.04
                    anchors.horizontalCenter: parent.horizontalCenter
                    indicator: Rectangle {}
                    background: Rectangle {
                        id: leftMenuButton6BG
                        color: !parent.enabled ? "#17252A" : (parent.hovered ? "#84CDC9" : (parent.checkState===Qt.Checked? "#2B837F" : "#3AAFA9"))
                        border.color: "#DEF2F1"
                        border.width: 1
                        radius: 10
                    }
                    onCheckStateChanged: {
                        if (leftMenuButton6.checked) {
                            mediaplayer1.source = backend.leftMenuButtonPressed(3, leftMenu.width + (alignVideo.border.width * 2), topBar.height + ((appWindow.height - alignVideo.height)/2) + (alignVideo.border.width * 2), videooutput.width, videooutput.height)
                            leftMenuButton1.enabled = false
                            leftMenuButton2.enabled = false
                            leftMenuButton3.enabled = false
                            leftMenuButton4.enabled = false
                            leftMenuButton5.enabled = false
                          //  leftMenuButton6.enabled = false
                            leftMenuButton7.enabled = false
                        } else {
                            mediaplayer1.source = " "
                            leftMenuButton1.enabled = true
                            leftMenuButton2.enabled = true
                            leftMenuButton3.enabled = true
                            leftMenuButton4.enabled = true
                            leftMenuButton5.enabled = true
                           // leftMenuButton6.enabled = true
                            leftMenuButton7.enabled = true
                        }
                    }
                }
                CheckBox {
                    id: leftMenuButton7
                    text: "Chromium"
                    font.bold: true
                    font.pointSize: 13
                    height: parent.height * 0.1
                    width: parent.width * 0.85
                    anchors.top: leftMenuButton6.bottom
                    anchors.topMargin: parent.height * 0.04
                    anchors.horizontalCenter: parent.horizontalCenter
                    indicator: Rectangle {}
                    background: Rectangle {
                        id: leftMenuButton7BG
                        color: !parent.enabled ? "#17252A" : (parent.hovered ? "#84CDC9" : (parent.checkState===Qt.Checked? "#2B837F" : "#3AAFA9"))
                        border.color: "#DEF2F1"
                        border.width: 1
                        radius: 10
                    }
                    onCheckStateChanged: {
                        if (leftMenuButton7.checked) {
                            mediaplayer1.source = backend.leftMenuButtonPressed(3, leftMenu.width + (alignVideo.border.width * 2), topBar.height + ((appWindow.height - alignVideo.height)/2) + (alignVideo.border.width * 2), videooutput.width, videooutput.height)
                            leftMenuButton1.enabled = false
                            leftMenuButton2.enabled = false
                            leftMenuButton3.enabled = false
                            leftMenuButton4.enabled = false
                            leftMenuButton5.enabled = false
                            leftMenuButton6.enabled = false
                          //  leftMenuButton7.enabled = false
                        } else {
                            mediaplayer1.source = " "
                            leftMenuButton1.enabled = true
                            leftMenuButton2.enabled = true
                            leftMenuButton3.enabled = true
                            leftMenuButton4.enabled = true
                            leftMenuButton5.enabled = true
                            leftMenuButton6.enabled = true
                           // leftMenuButton7.enabled = true
                        }
                    }
                }
            }
}
*/
