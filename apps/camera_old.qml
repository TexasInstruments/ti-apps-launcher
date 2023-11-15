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
    id: camerarecord
    visible: true
    height: Screen.desktopAvailableHeight * 0.6
    width: Screen.desktopAvailableWidth * 0.825    
    property int count:0
    Rectangle {
        id: backgroundrect
        width: parent.width
        height: parent.height
        Image {
            id: backgroundimage
            source: "file://home/root/jacinto_oob_demo_home_image.png"
            width: parent.width
            height: parent.height
        }
        Image {
            id: recordbutton
            height: parent.height * 0.1
            width: height
            source: "file:///opt/ti-apps-launcher/assets/record.png"
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            visible: true
            property int flag: 0
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if(camerarecord.count == 0) {
                        camerarecord.count += 1
                        statustext.text = "Recording"
                        recordbutton.source = "file:///opt/ti-apps-launcher/assets/stop-button.png"
                        camerarecorder.startrec()
                    }
                    else if(camerarecord.count == 1) {
                        camerarecord.count += 1
                        statustext.text = "Camera"
                        recordbutton.source = "file:///opt/ti-apps-launcher/assets/playbutton.png"
                        camerarecorder.stoprec()
                    }
                    else if(camerarecord.count == 2) {
                        recordbutton.source = "file:///opt/ti-apps-launcher/assets/videostop.png"
                        camerarecord.count += 1
                        statustext.text = "Playing"
                        camerarecorder.startvideo()
                        isvideoover.running = true
                    }
                    else if(camerarecord.count == 3) {
                        camerarecord.count = 0
                        isvideoover.running = false
                        statustext.text = "Camera"
                        recordbutton.source = "file:///opt/ti-apps-launcher/assets/record.png"
                        camerarecorder.stopvideo()
                    }
                }
            }
            Timer {
                id: isvideoover
                interval: 1000 // interval in milliseconds
                running: false // start the timer
                repeat: true // repeat the timer
                onTriggered: {
                    recordbutton.flag = camerarecorder.isvideocomplete()
                    if(recordbutton.flag == 1) {
                        camerarecorder.playcam()
                        camerarecord.count = 0
                        statustext.text = "Camera"
                        recordbutton.source = "file:///opt/ti-apps-launcher/assets/record.png"
                        isvideoover.running = false
                    }
                }
            }
        }
        Rectangle {
            id: camstatus
            width: parent.width * 0.13
            height: parent.height * 0.04
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            color: "transparent"
            Text {
                id:statustext
                text: qsTr("Camera")
                color: "green"
                font.pixelSize: parent.width * 0.1
                font.bold: true
                anchors.centerIn: parent
            }
        }
    }
}
