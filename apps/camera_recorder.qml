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
    height: parent.height
    width: parent.width

    MediaPlayer {
        id: mediaplayer
        source: "gst-pipeline: v4l2src device=/dev/video0 ! video/x-raw, width=640, height=480, format=UYVY ! videoconvert ! qtvideosink"
        autoPlay: true
    }

    VideoOutput {
        anchors.fill: parent
        source: mediaplayer
    }
}
