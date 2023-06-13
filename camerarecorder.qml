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
    id: camerarecorder
    visible: true
    width: 1584
    height: 648    
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
                    //camrecbackend.stopcam()
                    //video.play()
                    if(camerarecorder.count==0) {
                        camrecbackend.startrec()
                        camerarecorder.count = 1
                    }
                    else {
                        camrecbackend.stoprec()
                        camerarecorder.count = 0
                    }
                }
            }
        }
    }
}