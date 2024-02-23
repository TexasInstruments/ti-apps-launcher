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
        id: camera_video_feed
        anchors.fill: parent

        MediaPlayer {
            id: mediaplayer
            autoPlay: false
        }

        Text {
            id: msg
            anchors.centerIn: parent
            text: "Select a Camera or Video to play here."
            font.pixelSize: 20
            color: "#000000"
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
                source: mediaplayer
                anchors.fill: parent
                anchors.centerIn: parent
                visible: true
                Image {
                    id: recording_status
                    visible: false
                    source: "file:///opt/ti-apps-launcher/assets/record.png"
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

                delegate: ItemDelegate {
                    width: cameras_dropdown.width
                    contentItem: Text {
                        text: textRole
                        color: "#21be2b"
                        font: cameras_dropdown.font
                        elide: Text.ElideRight
                        verticalAlignment: Text.AlignVCenter
                    }
                    highlighted: cameras_dropdown.highlightedIndex === index
                }

                indicator: Canvas {
                    id: canvas
                    x: cameras_dropdown.width - width - cameras_dropdown.rightPadding
                    y: cameras_dropdown.topPadding + (cameras_dropdown.availableHeight - height) / 2
                    width: 12
                    height: 8
                    contextType: "2d"

                    Connections {
                        target: cameras_dropdown
                        function onPressedChanged() { canvas.requestPaint(); }
                    }

                    onPaint: {
                        context.reset();
                        context.moveTo(0, 0);
                        context.lineTo(width, 0);
                        context.lineTo(width / 2, height);
                        context.closePath();
                        context.fillStyle = cameras_dropdown.pressed ? "#17a81a" : "#21be2b";
                        context.fill();
                    }
                }

                contentItem: Text {
                    leftPadding: 0
                    rightPadding: cameras_dropdown.indicator.width + cameras_dropdown.spacing

                    text: cameras_dropdown.displayText
                    font: cameras_dropdown.font
                    color: cameras_dropdown.pressed ? "#17a81a" : "#21be2b"
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }

                background: Rectangle {
                    implicitWidth: 120
                    implicitHeight: 40
                    border.color: cameras_dropdown.pressed ? "#17a81a" : "#21be2b"
                    border.width: cameras_dropdown.visualFocus ? 2 : 1
                    radius: 2
                }

                popup: Popup {
                    y: cameras_dropdown.height - 1
                    width: cameras_dropdown.width
                    implicitHeight: contentItem.implicitHeight
                    padding: 1

                    contentItem: ListView {
                        clip: true
                        implicitHeight: contentHeight
                        model: cameras_dropdown.popup.visible ? cameras_dropdown.delegateModel : null
                        currentIndex: cameras_dropdown.highlightedIndex

                        ScrollIndicator.vertical: ScrollIndicator { }
                    }

                    background: Rectangle {
                        border.color: "#21be2b"
                        radius: 2
                    }
                }

                onActivated: {
                    mediaplayer.stop();
                    mediaplayer.source = camera.play_camera(cameras_dropdown.currentText)
                    mediaplayer.play();
                }
            }

            Image {
                id: camera_record_button
                height: parent.height * 0.8
                width: height
                property bool recording: false
                source: recording ? "file:///opt/ti-apps-launcher/assets/stop.png" : "file:///opt/ti-apps-launcher/assets/record.png"
                fillMode: Image.PreserveAspectFit
                anchors.left: cameras_dropdown.right
                anchors.leftMargin: parent.width * 0.01
                anchors.verticalCenter: parent.verticalCenter

                MouseArea {
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
                        } else {
                            camera_record_button.recording = false;
                            recording_animation.stop()
                            recording_status.visible = false
                            mediaplayer.stop();
                            mediaplayer.source = camera.play_camera(cameras_dropdown.currentText);
                            mediaplayer.play();
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
                source: "file:///opt/ti-apps-launcher/assets/playbutton.png"
                fillMode: Image.PreserveAspectFit
                anchors.left: videosDropdown.right
                anchors.leftMargin: parent.width * 0.01
                anchors.verticalCenter: parent.verticalCenter

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        mediaplayer.stop();
                        var inputFile = videosDropdown.model.get(videosDropdown.currentIndex, "filePath");
                        var videopipeline = camera.play_video(inputFile);
                        mediaplayer.source = videopipeline;
                        mediaplayer.play();
                    }
                }
            }
            Image {
                id: gallery_delete_button
                height: parent.height * 0.8
                width: height
                property bool playing: false
                source: "file:///opt/ti-apps-launcher/assets/delete.png"
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
                msg.visible = true
                feed.visible = false
            } else {
                msg.visible = false
                feed.visible = true
                cameras_dropdown.currentIndex = 0;
                mediaplayer.source = camera.play_camera(cameralist.data(cameralist.index(0,0)));
                mediaplayer.play();
            }
        }
    }
}
