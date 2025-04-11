import QtQml 2.1
import QtQuick 2.14
import QtMultimedia
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3
import org.freedesktop.gstreamer.Qt6GLVideoItem 1.0

Rectangle {
    id: camerarecorder
    visible: true
    height: parent.height
    width: parent.width
    color: "#344045"

    Text {
        id: no_cameras
        anchors.centerIn: parent
        text: "No camera detected! Please check the connection and reboot."
        font.pixelSize: 20
        color: "#EEFFFF"
    }

    GstGLQt6VideoItem {
        objectName: "streamItem"
        id: camera_feed
        anchors.fill: parent

        RowLayout {
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 10

            Repeater {
                id: camera_buttons
                model: live_camera.liveCamera_get_count()

                Button {
                    width: parent.width * 0.1
                    height: parent.height * 0.1
                    text: live_camera.liveCamera_get_camera_name(index)
                    onClicked: {
                        live_camera.liveCamera_update_gst_pipeline(text)
                        live_camera.stopStream()
                        live_camera.startStream(camera_feed)
                    }
                }
            }
        }

        onItemInitializedChanged: {
            if (camera_buttons.model == 0) {
                no_cameras.visible = true
                camera_feed.visible = false
            } else {
                no_cameras.visible = false
                camera_feed.visible = true
                live_camera.liveCamera_update_gst_pipeline(camera_buttons.itemAt(0).text)
                live_camera.stopStream()
                live_camera.startStream(camera_feed)
            }
        }
        Component.onDestruction: {
            live_camera.stopStream()
        }
    }
}
