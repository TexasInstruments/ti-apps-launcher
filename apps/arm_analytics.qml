import QtQml 2.1
import QtQuick 2.14
import QtMultimedia
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3

Rectangle {
    id: arm_analytics_app
    visible: true
    height: parent.height
    width: parent.width
    color: "#344045"

    MediaPlayer {
        id: mediaplayer
        videoOutput: analytics_feed
    }

    VideoOutput {
        id: analytics_feed
        anchors.fill: parent

        RowLayout {
            id: analytics_buttons
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 10

            Button {
                width: parent.width * 0.1
                height: parent.height * 0.1
                text: "Object Detection"
                onClicked: {
                    arm_analytics.armAnalytics_update_gst_pipeline(text)
                    mediaplayer.stop()
                    mediaplayer.source = arm_analytics.armAnalytics_gst_pipeline()
                    mediaplayer.play()
                }
            }
            Button {
                width: parent.width * 0.1
                height: parent.height * 0.1
                text: "Face Detection"
                onClicked: {
                    arm_analytics.armAnalytics_update_gst_pipeline(text)
                    mediaplayer.stop()
                    mediaplayer.source = arm_analytics.armAnalytics_gst_pipeline()
                    mediaplayer.play()
                }
            }

            Button {
                width: parent.width * 0.1
                height: parent.height * 0.1
                text: "Image Classification"
                onClicked: {
                    arm_analytics.armAnalytics_update_gst_pipeline(text)
                    mediaplayer.stop()
                    mediaplayer.source = arm_analytics.armAnalytics_gst_pipeline()
                    mediaplayer.play()
                }
            }
        }
    }

    Component.onCompleted: {
        arm_analytics.armAnalytics_update_gst_pipeline("Object Detection")
        mediaplayer.stop()
        mediaplayer.source = arm_analytics.armAnalytics_gst_pipeline()
        mediaplayer.play()
    }
}

