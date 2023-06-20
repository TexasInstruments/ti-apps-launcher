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
        autoPlay: false
    }

    VideoOutput {
        anchors.fill: parent
        source: mediaplayer

        RowLayout {
            anchors.bottom: parent.bottom

            Repeater {
               model: live_camera.liveCamera_get_count()

                Button {
                    width: parent.width * 0.1
                    height: parent.height * 0.1
                    text: live_camera.liveCamera_get_camera_name(index)
                    palette {
                        button: "#FF0000"
                    }
                    onClicked: {
                        live_camera.liveCamera_update_gst_pipeline(text)
                        mediaplayer.stop()
                        mediaplayer.source = live_camera.liveCamera_gst_pipeline()
                        mediaplayer.play()
                    }
                }
            }
        }
    }
}
