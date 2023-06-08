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
        color: "#A0A0A0"
        Slider {
            id: slider2
            orientation: Qt.Vertical
            from: 0
            to: 100
            value: 0
            stepSize: 1
            anchors.right: parent.right
            anchors.rightMargin: parent.width * 0.05
            anchors.verticalCenter: parent.verticalCenter
            //visible:false
            //width: parent.width * 0.6
            onValueChanged: {
                if (value < 20) {
                //    gpulevel.text = qsTr("0")
                    backend.gpuload0()
                }
                else if (value < 40) {
                    backend.gpuload1()
                }
                else if (value < 60) {
                    backend.gpuload2()
                }
                else if (value < 80) {
                    backend.gpuload3()
                }
                else {
                    backend.gpuload4()
                }
            }
        }

    }
}