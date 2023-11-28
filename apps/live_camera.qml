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
    color: "#344045"

    MediaPlayer {
        id: mediaplayer
        autoPlay: false
    }

    Text {
        id: no_cameras
        anchors.centerIn: parent
        text: "No camera detected! Please check the connection and reboot."
        font.pixelSize: 20
        color: "#EEFFFF"
    }

    VideoOutput {
        id: camera_feed
        anchors.fill: parent
        source: mediaplayer

        property string selected_camera: ""
        property string cam_function: "live"

        Button {
            id: camera_shutter
            property bool recording: false
            text: recording ? "Stop" : "Record"
            onClicked: {
                if (recording === false) {
                    recording = true
                    camera_feed.cam_function = "record"
                    live_camera.liveCamera_update_gst_pipeline_camera(camera_feed.selected_camera)
                    live_camera.liveCamera_update_gst_pipeline_function(camera_feed.cam_function)
                    mediaplayer.stop()
                    mediaplayer.source = live_camera.liveCamera_gst_pipeline()
                    mediaplayer.play()
                    camera_playback.enabled = false
                } else {
                    recording = false
                    camera_feed.cam_function = "live"
                    live_camera.liveCamera_update_gst_pipeline_camera(camera_feed.selected_camera)
                    live_camera.liveCamera_update_gst_pipeline_function(camera_feed.cam_function)
                    mediaplayer.stop()
                    mediaplayer.source = live_camera.liveCamera_gst_pipeline()
                    mediaplayer.play()
                    camera_playback.enabled = true
                }
            }
        }

        Button {
            id: camera_playback
            enabled: true
            text: "playback"
            anchors.bottom: parent.bottom
            onClicked: {
                mediaplayer.stop()
                mediaplayer.source = "gst-pipeline: playbin uri=file:///opt/ti-apps-launcher/data/ti-apps-launcher.h264 video-sink=qtvideosink"
                mediaplayer.play()
            }
        }

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
                        camera_feed.selected_camera = text
                        live_camera.liveCamera_update_gst_pipeline_camera(text)
                        live_camera.liveCamera_update_gst_pipeline_function("live")
                        mediaplayer.stop()
                        mediaplayer.source = live_camera.liveCamera_gst_pipeline()
                        mediaplayer.play()
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        if (live_camera.liveCamera_get_count() == 0) {
            no_cameras.visible = true
            camera_feed.visible = false
        } else {
            no_cameras.visible = false
            camera_feed.visible = true

            camera_feed.selected_camera = camera_buttons.itemAt(0).text
            live_camera.liveCamera_update_gst_pipeline_camera(camera_buttons.itemAt(0).text)
            live_camera.liveCamera_update_gst_pipeline_function("live")
            mediaplayer.stop()
            mediaplayer.source = live_camera.liveCamera_gst_pipeline()
            mediaplayer.play()
        }
    }
}
