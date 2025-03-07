import QtQml 2.1
import QtQuick 2.14
import QtMultimedia
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3

Rectangle {
    id: codecs
    visible: true
    height: parent.height
    width: parent.width
    color: "#344045"

    MediaPlayer {
        id: mediaplayer
        autoPlay: true
        source: "gst-pipeline: multifilesrc location=/opt/edgeai-test-data/videos/video0_1280_768.h264 loop=true caps=video/x-h264,width=1280,height=768,framerate=30/1 ! h264parse ! v4l2h264dec ! ticolorconvert ! video/x-raw, format=NV12 ! queue ! tiperfoverlay overlay-type=text main-title=\"H.264 Video\" ! qtvideosink"
    }

    VideoOutput {
        id: video_feed
        anchors.fill: parent
        source: mediaplayer

        Button {
            width: parent.width * 0.1
            height: parent.height * 0.05
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.leftMargin: parent.width * 0.35
            text: "H.264"
            onClicked: {
                mediaplayer.stop()
                mediaplayer.source = "gst-pipeline: multifilesrc location=/opt/edgeai-test-data/videos/video0_1280_768.h264 loop=true caps=video/x-h264,width=1280,height=768,framerate=30/1 ! h264parse ! v4l2h264dec ! ticolorconvert ! video/x-raw, format=NV12 ! queue ! tiperfoverlay overlay-type=text main-title=\"H.264 Video\" ! qtvideosink"
                mediaplayer.play()
            }
        }
        Button {
            width: parent.width * 0.1
            height: parent.height * 0.05
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.rightMargin: parent.width * 0.35
            text: "H.265"
            onClicked: {
                mediaplayer.stop()
                mediaplayer.source = "gst-pipeline: multifilesrc location=/opt/edgeai-test-data/videos/video0_1280_768.h265 loop=true caps=video/x-h265,width=1280,height=768,framerate=30/1 ! h265parse ! v4l2h265dec ! ticolorconvert ! video/x-raw, format=NV12 ! queue ! tiperfoverlay overlay-type=text main-title=\"H.265 Video\" ! qtvideosink"
                mediaplayer.play()
            }
        }
    }
}
