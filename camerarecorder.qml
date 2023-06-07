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
    id: camerarecorder
    visible: true
    width: 640
    height: 480
    //visibility: "FullScreen"
    title : qsTr("Camera Recorder")
    property int count:0
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
        Image {
            id: recordbutton
            height: parent.height * 0.1
            width: height
            source: "images/playbutton.png"
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if(camerarecorder.count==0) {
                        backend.startrec()
                        camerarecorder.count = 1
                    }
                    else {
                       backend.stoprec()
                        camerarecorder.count = 0
                    }
                }
            }
        }
    }
}