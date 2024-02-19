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
    id: camera_recorder
    visible: true
    height: parent.height
    width: parent.width
    color: "#344045"

    Rectangle {
        id: recorder_menu

        width: parent.width * 0.2
        height: parent.height * 0.95
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: parent.width * 0.02
        border.color: "#EEFFFF"
        border.width: 5
        radius: 10

        Rectangle {
            id: codec_menu
            width: parent.width
            height: parent.height * 0.1
            anchors.top: parent.top
            color: "red"

            Text {
                id: codec_head
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                text: "Codec"
                font.pixelSize: 20
                color: "#000000"
            }

            Switch {
                id: codec_switch
                checked: false
                height: parent.height * 0.6
                width: parent.width * 0.7
                anchors.bottom: parent.bottom
                anchors.bottomMargin: parent.height * 0.04
                anchors.horizontalCenter: parent.horizontalCenter
                indicator: Rectangle {
                    implicitWidth: parent.width
                    implicitHeight: parent.height
                    x: codec_switch.leftPadding
                    y: parent.height / 2 - height / 2
                    radius: implicitHeight / 2
                    color: codec_switch.checked ? "#566673" : "#ffffff"
                    border.color: codec_switch.checked ? "#ffffff" : "#D0D3D4"

                    Rectangle {
                        x: codec_switch.checked ? parent.width - width : 0
                        implicitHeight: parent.height * 1.2
                        width: height
                        anchors.verticalCenter: parent.verticalCenter
                        radius: implicitHeight
                        color: "#1B2631"
                        border.color: codec_switch.checked ? "#D0D3D4" : "#ffffff"
                    }

                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        width: parent.width
                        leftPadding: 10
                        rightPadding: 10
                        text: codec_switch.checked ? ".h265" : ".h264"
                        font.pixelSize: 20
                        horizontalAlignment: codec_switch.checked ? Text.AlignLeft : Text.AlignRight
                        color: codec_switch.checked ? "#ffffff" : "#1B2631"
                    }
                }
                onClicked: {
                    camera.update_codec(checked);
                    if (checked === true) {
                        videofiles.nameFilters = [ "*.h265" ]
                    }
                    else {
                        videofiles.nameFilters = [ "*.h264" ]
                    }
                }
            }
        }
        Rectangle {
            id: camera_menu
            width: parent.width
            height: parent.height * 0.6

            anchors.top: codec_menu.bottom
            Text {
                id: camera_head
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                text: "Camera"
                font.pixelSize: 20
                color: "#000000"
            }

            ColumnLayout {
                id: cameras_column
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width
                spacing: 0
                height: parent.height * 0.2
                Repeater {
                    id: camera_buttons
                    model: camera.get_count()

                    Button {
                        width: parent.width * 0.8
                        height: parent.height * 0.2
                        text: camera.get_camera_name(index)
                        onClicked: {
                            camera.update_gst_pipeline(text)
                            mediaplayer.stop()
                            mediaplayer.source = camera.get_gst_pipeline()
                            mediaplayer.play()
                        }
                    }
                }
            }
        }
        Rectangle {
            id: gallery
            width: parent.width
            height: parent.height

            anchors.top: camera_menu.bottom

            ComboBox {
                id: videosDropdown
                width: parent.width * 0.6
                height: parent.height * 0.2
                anchors.left: parent.left
                anchors.leftMargin: parent.width * 0.2
                anchors.top: popupInputType.bottom
                anchors.topMargin: parent.height * 0.1

                FolderListModel{
                    id: videofiles
                    folder: "file:///opt/ti-apps-launcher/gallery/"
                    nameFilters: [ "*.h264" ]
                }

                model: inputVideosFolder
                textRole: 'fileName'
            }
        }
    }

    Rectangle {
        id: camera_video_feed
        width: parent.width * 0.75
        height: parent.height * 0.95
        anchors.right: parent.right
        anchors.rightMargin: parent.width * 0.02
        anchors.verticalCenter: parent.verticalCenter
        color: "black"
        border.color: "#EEFFFF"
        border.width: 5
        radius: 10

        MediaPlayer {
            id: mediaplayer
            autoPlay: false
        }

        Text {
            id: no_cameras
            anchors.centerIn: parent
            text: "No camera detected! Please check the connection and reboot."
            font.pixelSize: 20
            color: "#000000"
        }

        VideoOutput {
            id: feed
            source: mediaplayer
            anchors.fill: parent
            anchors.centerIn: parent
            // anchors.margins: 10
        }

        Component.onCompleted: {
            if (camera.get_count() == 0) {
                no_cameras.visible = true
                feed.visible = false
            } else {
                no_cameras.visible = false
                feed.visible = true

                camera.update_gst_pipeline(camera_buttons.itemAt(0).text)
                mediaplayer.stop()
                mediaplayer.source = camera.get_gst_pipeline()
                mediaplayer.play()
            }
        }
    }
}
