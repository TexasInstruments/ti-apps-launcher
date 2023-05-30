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
Window {
    visible: true
    visibility: "FullScreen"
    title: qsTr("AM6x HMI")
    Rectangle {
        id: appBackground
        color: "#17252A"
        width: parent.width
        height: parent.height
        Rectangle {
            id: topBar
            width: parent.width
            height: parent.height * 0.1
            anchors.top: parent.top
            anchors.left: parent.left
            color: "#17252A"

            Image {
                id: topBarLogo
                scale: Qt.KeepAspectRatio
                height: parent.height
                width: height * 2.84 // To maintain the aspect ratio of the image
                anchors.top: parent.top
                anchors.topMargin: parent.height * 0.1
                source: "../images/Texas-Instruments.png"
            }

            Text {
                id: topBarHead
                objectName: "topBarHead"
                text: qsTr("AM6x HMI")

                width: parent.width * 0.8
                height: parent.height
                anchors.left: topBarLogo.right
                anchors.top: parent.top

                color: "#FEFFFF"
                font.family: "Ubuntu"
                font.bold: true
                font.pointSize: 35
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }

            Button {
                id: topBarExitButton
                onClicked: Qt.quit()
                height: parent.height * 0.2
                width: height

                anchors.right: parent.right
                anchors.rightMargin: width * 0.5
                anchors.top: parent.top
                anchors.topMargin: height * 0.5

                background: Rectangle {
                    Text {
                        text: "×"
                        font.pointSize: 12
                        color: "#FEFFFF"
                        anchors.centerIn: parent
                        font.bold: true
                    }
                    color: "#FF0000"
                    radius: parent.height
                }
            }
        }
        Rectangle {
            id: leftMenu

            width: parent.width * 0.15
            height: parent.height * 0.85
            anchors.top: topBar.bottom
            anchors.left: parent.left

            color: "#17252A"

            Rectangle {
                id: leftSubMenu

                width: parent.width * 0.9
                height: parent.height * 0.6
                anchors.horizontalCenter: leftMenu.horizontalCenter
                anchors.verticalCenter: leftMenu.verticalCenter
                color: "#344045"

                border.color: "#DEF2F1"
                border.width: 1
                radius: 10

                CheckBox {
                    id: leftMenuButton1
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
                         //   leftMenuButton1.enabled = false
                            leftMenuButton2.enabled = false
                            leftMenuButton3.enabled = false
                            leftMenuButton4.enabled = false
                            leftMenuButton5.enabled = false
                            leftMenuButton6.enabled = false
                            leftMenuButton7.enabled = false

                            
                            //window.visible = true
                            //qmlloader.active = true
                            qmlloader.source = "industrial_control.qml"
                            
                            //qmlloader.active = true
                            
                        } else {
                            mediaplayer1.source = " "
                         //   leftMenuButton1.enabled = true
                            leftMenuButton2.enabled = true
                            leftMenuButton3.enabled = true
                            leftMenuButton4.enabled = true
                            leftMenuButton5.enabled = true
                            leftMenuButton6.enabled = true
                            leftMenuButton7.enabled = true

                            qmlloader.source = ""
                            //qmlloader.active = false
                            //qmlloader.active = false
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
                             
                            qmlloader.source = "camera_recorder.qml"
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
                            qmlloader.source = ""
                          
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
                            qmlloader.source = "benchmarks.qml"
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
                            qmlloader.source = ""
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
                            qmlloader.source = "gpu_performance.qml"

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
                            qmlloader.source = ""
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
                            mediaplayer1.source = backend.leftMenuButtonPressed(3, leftMenu.width + (alignVideo.border.width * 2), topBar.height + ((mainWindow.height - alignVideo.height)/2) + (alignVideo.border.width * 2), videooutput.width, videooutput.height)
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
                            mediaplayer1.source = backend.leftMenuButtonPressed(3, leftMenu.width + (alignVideo.border.width * 2), topBar.height + ((mainWindow.height - alignVideo.height)/2) + (alignVideo.border.width * 2), videooutput.width, videooutput.height)
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
                            mediaplayer1.source = backend.leftMenuButtonPressed(3, leftMenu.width + (alignVideo.border.width * 2), topBar.height + ((mainWindow.height - alignVideo.height)/2) + (alignVideo.border.width * 2), videooutput.width, videooutput.height)
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
        Rectangle {
            id: mainWindow
            color: "#17252A"
            width: parent.width * 0.825
            height: parent.height * 0.6
            anchors.top: topBar.bottom
            anchors.left: leftMenu.right
            anchors.rightMargin: parent.width * 0.025
            property int count: 0
            
            Rectangle {
                id: alignVideo
                width: parent.width
                height: (parent.width / 16) * 9
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                //anchors.topMargin: (parent.height - height) / 2
                border.color: "#DEF2F1"
                border.width: 3

                radius: 10
                color: "#17252A"
                    
                

                MediaPlayer {
                    id: mediaplayer1
                    objectName: "mediaplayer1"
                    // source: is provided by the Cpp Backend
                    autoPlay: true
                }

                VideoOutput {
                    id: videooutput
                    width: parent.width
                    height: parent.height
                    source: mediaplayer1
                    fillMode: VideoOutput.PreserveAspectCrop
                    anchors.fill: parent
                    anchors.margins: parent.border.width * 2
                } 
            }
            Image {
                id:mainimg
                visible: true
                width: parent.width
                height: parent.height
                source: "file://home/root/jacinto_oob_demo_home_image.png"
                anchors.fill: parent
                anchors.margins: parent.border.width * 2
            }
            Item{
                anchors.centerIn: parent
                //anchors.top: parent.top
                //anchors.left: parent.left
                //anchors.right: parent.right
                //anchors.bottom: parent.bottom
                Loader {
                    id:qmlloader
                    anchors.centerIn: parent
                }
            }
            
        }
        
        Rectangle {
            id:cpuloadWindow
            anchors.left: mainWindow.left
            anchors.right: mainWindow.right
            anchors.top: mainWindow.bottom
            height: parent.height * 0.24
            color: "#17252A" 
            Item{
                anchors.centerIn: parent
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                Loader {
                    id:statsloader
                    anchors.centerIn: parent
                    source: "stats.qml"
                }
            }
        }
        

        Rectangle {
            id: deviceInfo
            anchors.left: mainWindow.left
            anchors.right: mainWindow.right
            anchors.top: cpuloadWindow.bottom
            anchors.bottom: parent.bottom
            color: "#17252A"
            Text {
                id: info1
                //text: "<font color=\"#FEFFFF\">Web: </font><font color=\"#FF0000\">https://ti.com/edgeai</font><font color=\"#FEFFFF\"> | Support: </font><font color=\"#FF0000\">https://e2e.ti.com/</font>"
                text: "<font color=\"#FEFFFF\"> Support: </font><font color=\"#FF0000\">https://e2e.ti.com/</font>"
                font.pointSize: 15
                anchors.verticalCenter: parent.verticalCenter
            }
            Text {
                id: ipAddr
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right

                text: backend.ip_addr
                color: "#FEFFFF"
                font.pointSize: 15
            }
        }
    }
}
