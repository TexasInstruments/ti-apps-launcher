import QtQml 2.1
import QtQuick 2.14
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3

import org.freedesktop.gstreamer.Qt6GLVideoItem 1.0

Rectangle {
    id: arm_analytics_app
    visible: true
    height: parent.height
    width: parent.width
    color: "#344045"

    GstGLQt6VideoItem {
        objectName: "videoItem"
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
                    arm_analytics.stopVideo();
                    arm_analytics.startVideo(analytics_feed, text);
                }
            }

            Button {
                width: parent.width * 0.1
                height: parent.height * 0.1
                text: "Image Classification"
                onClicked: {
                    arm_analytics.stopVideo();
                    arm_analytics.startVideo(analytics_feed, text);
                }
            }
        }
    }

    Component.onCompleted: {
//        arm_analytics.startVideo(analytics_feed, "Object Detection");
    }
    Component.onDestruction: {
        arm_analytics.stopVideo();
    }
}

