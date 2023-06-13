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
        Rectangle {
            id:benchmarkswindow
            //visible: false
            height: parent.height * 0.5
            width: parent.width * 0.5
            anchors.top: parent.top
            anchors.topMargin: parent.height * 0.25
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height * 0.25
            anchors.left: parent.left
            anchors.leftMargin: parent.width * 0.25
            anchors.right: parent.right
            anchors.rightMargin: parent.width * 0.25

            Rectangle {
                id: index00
                height: parent.height * 0.2
                width: parent.width * 0.25
                anchors.top:parent.top
                anchors.left:parent.left

                Text {
                    id: index00text
                    text: qsTr("gl_manhattan_off")
                    color: "#F44336"
                    font.pixelSize: parent.width * 0.1
                    anchors.centerIn: parent
                }
            }
            Rectangle {
                id:index01
                height: parent.height * 0.2
                width: parent.width * 0.25
                anchors.top:parent.top
                anchors.left:index00.right

                Text {
                    id: index01text
                    text: qsTr("0")
                    color: "#F44336"
                    font.pixelSize: parent.width * 0.17
                    anchors.centerIn: parent
                }
            }
            Rectangle {
                id:index02
                height: parent.height * 0.2
                width: parent.width * 0.25
                anchors.top:parent.top
                anchors.left:index01.right

                Text {
                    id: index02text
                    text: qsTr("0")
                    color: "#F44336"
                    font.pixelSize: parent.width * 0.17
                    anchors.centerIn: parent
                }
            }
            Rectangle {
                id: index03
                height: parent.height * 0.2
                width: parent.width * 0.25
                anchors.top:parent.top
                anchors.left:index02.right
                property int flag1: 0
                Image {
                    id: playmanhat
                    scale: Qt.KeepAspectRatio
                    height: parent.height * 0.8
                    width: height  // To maintain the aspect ratio of the image
                    anchors.top: parent.top
                    anchors.topMargin: parent.height * 0.1
                    source: "images/playbutton.png"
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if(index03.flag1 == 0) {
                                backend3.playbutton1pressed()
                                index03.flag1 = 1
                                playbutton1timer.running = true
                            }
                            else {
                                backend3.playbutton1pressedagain()
                                index03.flag1 = 0
                                playbutton1timer.running = false
                                //index01text.text = backend3.playbutton1fps()
                                //index02text.text = backend3.playbutton1score()
                            }
                        }
                    }
                }
                Timer {
                    id: playbutton1timer
                    interval: 73000
                    running: false
                    repeat: false
                    onTriggered: {
                        index03.flag1 = 0
                        index01text.text = backend3.playbutton1fps()
                        index02text.text = backend3.playbutton1score()
                    }
                }
            }
        } 
    }                
}   