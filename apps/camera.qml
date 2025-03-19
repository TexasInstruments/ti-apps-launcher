import QtQml 2.1
import QtQuick 2.14
import QtMultimedia
import QtQuick.Controls 2.1
import Qt.labs.folderlistmodel 2.4
import QtQuick.Layouts 1.3

Rectangle {
    id: camera_recorder
    visible: true
    height: parent.height
    width: parent.width
    color: "#344045"

    Rectangle {
        id: camera_video_feed
        anchors.fill: parent

        MediaPlayer {
            id: mediaplayer
            videoOutput: feed
            onPlaybackStateChanged: {
                if (playbackState !== PlayingState) {
                    msg.visible = msg.state
                    status_message.text = msg.state ? (" ") : ("Live: " + camera.get_current_camera())
                    camera_record_button.source = msg.state ? "/images/record-disabled.png" : "/images/record.png"
                    camera_record_button_mousearea.enabled = msg.state ? false : true
                }
            }
        }

        Rectangle {
            width: parent.width - (parent.height * 0.02)
            height: parent.height * 0.98
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            color: "white"
            // border.color: "#EEFFFF"
            // border.width: 5
            radius: 10

            VideoOutput {
                id: feed
                anchors.fill: parent
                anchors.centerIn: parent
                visible: true
                Text {
                    id: status_message
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.topMargin: parent.height * 0.02
                    anchors.leftMargin: parent.height * 0.02
                    color: "black"
                    text: ""
                    font.pixelSize: 25
                }
                Text {
                    id: msg
                    property bool state: false
                    visible: state
                    anchors.centerIn: parent
                    text: "No Camera Detected! Please check the connections and DTBO(s) applied."
                    font.pixelSize: 20
                    color: "red"
                }
                Image {
                    id: recording_status
                    visible: false
                    source: "/images/record.png"
                    fillMode: Image.PreserveAspectFit
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.rightMargin: parent.height * 0.02
                    anchors.topMargin: parent.height * 0.02
                }
                Timer {
                    id: recording_animation
                    interval: 500; running: false; repeat: true
                    onTriggered: {
                        if(recording_status.visible == true) {
                            recording_status.visible = false
                        } else {
                            recording_status.visible = true
                        }
                    }
                }
            }
        }

        Rectangle {
            id: recorder_menu

            width: parent.width * 0.9
            height: parent.height * 0.1
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height * 0.05
            border.color: "#EEFFFF"
            border.width: 5
            radius: 10
            color: "#cccccc"

            Text {
                id: codec_head
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: parent.width * 0.01
                text: "Codec: "
                font.pixelSize: 25
                color: "#000000"
            }

            Switch {
                id: codec_switch
                checked: false
                height: parent.height * 0.5
                width: parent.width * 0.1
                anchors.left: codec_head.right
                anchors.verticalCenter: parent.verticalCenter
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
                        font.pixelSize: 15
                        horizontalAlignment: codec_switch.checked ? Text.AlignLeft : Text.AlignRight
                        color: codec_switch.checked ? "#ffffff" : "#1B2631"
                    }
                }
                onClicked: {
                    camera.update_codec(checked);
                    if (checked === true) {
                        videofiles.nameFilters = [ "*h265*" ]
                    }
                    else {
                        videofiles.nameFilters = [ "*h264*" ]
                    }
                }
            }
            Text {
                id: camera_head
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: codec_switch.right
                anchors.leftMargin: parent.width * 0.01
                text: "Camera: "
                font.pixelSize: 25
                color: "#000000"
            }

            ComboBox {
                id: cameras_dropdown
                width: parent.width * 0.25
                height: parent.height * 0.8
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: camera_head.right
                property int cameras_count: camera.get_count();

                model: cameralist
                textRole: "display"

                onActivated: {
                    mediaplayer.stop();
                    mediaplayer.source = camera.play_camera(cameras_dropdown.currentText)
                    mediaplayer.play();
                    status_message.text = "Live: " + camera.get_current_camera()
                }
            }

            Image {
                id: camera_record_button
                height: parent.height * 0.8
                width: height
                property bool recording: false
                source: "/images/record.png"
                fillMode: Image.PreserveAspectFit
                anchors.left: cameras_dropdown.right
                anchors.leftMargin: parent.width * 0.01
                anchors.verticalCenter: parent.verticalCenter

                MouseArea {
                    id: camera_record_button_mousearea
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        if (camera_record_button.recording == false) {
                            camera_record_button.recording = true;
                            // recording_status.visible = true
                            recording_animation.start()
                            mediaplayer.stop();
                            mediaplayer.source = camera.record_camera(cameras_dropdown.currentText);
                            mediaplayer.play();
                            status_message.text = "Recording: " + camera.get_current_camera() + " to " + camera.get_filename()
                            camera_record_button.source = "/images/stop.png"
                            gallery_play_button.source = "/images/playbutton-disabled.png"
                            gallery_play_button_mousearea.enabled = false
                        } else {
                            camera_record_button.recording = false;
                            recording_animation.stop()
                            recording_status.visible = false
                            mediaplayer.stop();
                            camera_record_button.source = "/images/record.png"
                            mediaplayer.source = camera.play_camera(cameras_dropdown.currentText);
                            mediaplayer.play();
                            if (msg.state == false) {
                                status_message.text = "Live: " + camera.get_current_camera()
                            } else {
                                status_message.text = " "
                            }
                            gallery_play_button.source = "/images/playbutton.png"
                            gallery_play_button_mousearea.enabled = true
                        }
                    }
                }
            }

            Text {
                id: gallery_head
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: camera_record_button.right
                anchors.leftMargin: parent.width * 0.01
                text: "Gallery: "
                font.pixelSize: 25
                color: "#000000"
            }

            ComboBox {
                id: videosDropdown
                width: parent.width * 0.25
                height: parent.height * 0.8
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: gallery_head.right

                FolderListModel{
                    id: videofiles
                    folder: "file:///opt/ti-apps-launcher/gallery/"
                    sortField :  "Time"
                    nameFilters: [ "*h264*" ]
                }

                model: videofiles
                textRole: 'fileName'
            }

            Image {
                id: gallery_play_button
                height: parent.height * 0.8
                width: height
                property bool playing: false
                source: "/images/playbutton.png"
                fillMode: Image.PreserveAspectFit
                anchors.left: videosDropdown.right
                anchors.leftMargin: parent.width * 0.01
                anchors.verticalCenter: parent.verticalCenter

                MouseArea {
                    id: gallery_play_button_mousearea
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        mediaplayer.stop();
                        var inputFile = videosDropdown.model.get(videosDropdown.currentIndex, "filePath");
                        var videopipeline = camera.play_video(inputFile);
                        msg.visible = false
                        mediaplayer.source = videopipeline;
                        mediaplayer.play();
                        status_message.text = "Playing: " + camera.get_filename()
                        camera_record_button.source = "/images/record-disabled.png"
                        camera_record_button_mousearea.enabled = false
                    }
                }
            }
            Image {
                id: gallery_delete_button
                height: parent.height * 0.8
                width: height
                property bool playing: false
                source: "/images/delete.png"
                fillMode: Image.PreserveAspectFit
                anchors.left: gallery_play_button.right
                anchors.leftMargin: parent.width * 0.01
                anchors.verticalCenter: parent.verticalCenter

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        // mediaplayer.stop();
                        var inputFile = videosDropdown.model.get(videosDropdown.currentIndex, "filePath");
                        camera.delete_video(inputFile);
                        videosDropdown.currentIndex = -1;
                        // var videopipeline = camera.play_video(inputFile);
                        // mediaplayer.source = videopipeline;
                        // mediaplayer.play();
                    }
                }
            }
        }
        Component.onCompleted: {
            if (cameras_dropdown.count == 0) {
                msg.state = true
                status_message.text = ""
                camera_record_button_mousearea.enabled = false
                camera_record_button.source = "/images/record-disabled.png"
            } else {
                msg.state = false
                cameras_dropdown.currentIndex = 0;
                mediaplayer.source = camera.play_camera(cameralist.data(cameralist.index(0,0)));
                mediaplayer.play();
                status_message.text = "Live: " + camera.get_current_camera()
            }
        }
    }
}
