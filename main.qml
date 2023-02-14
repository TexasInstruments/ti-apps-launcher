import QtQuick 2.1
import QtQuick.Window 2.1
import QtQuick.Controls 2.1
import QtMultimedia 5.1
import Qt.labs.folderlistmodel 2.4
import QtGraphicalEffects 1.12

Window {
    visible: true
    visibility: "FullScreen"
    title: qsTr("AM62A EdgeAI Demo")

    Rectangle {
        id: appBackground
        color: "#17252A"
        width: parent.width
        height: parent.height

        Rectangle {
            id: topBar
            width: parent.width
            height: parent.height * 0.1
            anchors.top: parent.top
            anchors.left: parent.left
            color: "#17252A"

            Image {
                id: topBarLogo
                scale: Qt.KeepAspectRatio
                width: parent.width * 0.2
                height: parent.height * 0.9
                anchors.top: parent.top
                anchors.topMargin: parent.height * 0.1
                source: "images/Texas-Instruments.png"
            }

            Text {
                id: topBarHead
                objectName: "topBarHead"
                text: qsTr("EdgeAI App")

                width: parent.width * 0.8
                height: parent.height
                anchors.left: topBarLogo.right
                anchors.top: parent.top

                color: "#FEFFFF"
                font.family: "Ubuntu"
                font.bold: true
                font.pointSize: 35
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }

            Button {
                id: topBarExitButton
                text: "×"
                onClicked: Qt.quit()
                height: parent.height * 0.2
                width: height

                anchors.right: parent.right
                anchors.rightMargin: width * 0.5
                anchors.top: parent.top
                anchors.topMargin: height * 0.5

                background: Rectangle {
                    color: parent.hovered ? "#FF0000" : "#CCCCCC"
                    radius: parent.height
                    /* Image {
                        source: "images/exit.png"
                        height: parent.height
                        width: parent.width
                    }
                    */
                }
            }
        }
        Rectangle {
            id: leftMenu

            width: parent.width * 0.15
            height: parent.height * 0.9
            anchors.top: topBar.bottom
            anchors.left: parent.left

            color: "#17252A"

            CheckBox {
                id: leftMenuButton1
                text: "Image Classification"

                height: parent.height * 0.1
                width: parent.width * 0.8
                anchors.top: parent.top
                anchors.topMargin: parent.height * 0.1
                anchors.horizontalCenter: parent.horizontalCenter
                indicator: Rectangle {}
                background: Rectangle {
                    id: leftMenuButton1BG
                    color: !parent.enabled ? "#17252A" : (parent.hovered ? "#84CDC9" : (parent.checkState===Qt.Checked? "#2B837F" : "#3AAFA9"))
                    border.color: "#DEF2F1"
                    border.width: 1
                    radius: 10
                }
                onCheckStateChanged: {
                    if (leftMenuButton1.checked) {
                        mediaplayer1.source = buttonsClicked.leftMenuButtonClicked(1, leftMenu.width, topBar.height + (mainWindow.height - alignVideo.height)/2, videooutput.width, videooutput.height)
                        leftMenuButton2.enabled = false
                        leftMenuButton3.enabled = false
                        leftMenuButton4.enabled = false
                    } else {
                        mediaplayer1.source = " "
                        leftMenuButton2.enabled = true
                        leftMenuButton3.enabled = true
                        leftMenuButton4.enabled = true
                    }
                }
            }

            CheckBox {
                id: leftMenuButton2
                text: "Semantic Segmentation"
                height: parent.height * 0.1
                width: parent.width * 0.8
                anchors.top: leftMenuButton1.bottom
                anchors.topMargin: parent.height * 0.1
                anchors.horizontalCenter: parent.horizontalCenter
                indicator: Rectangle {}
                background: Rectangle {
                    id: leftMenuButton2BG
                    color: !parent.enabled ? "#17252A" : (parent.hovered ? "#84CDC9" : (parent.checkState===Qt.Checked? "#2B837F" : "#3AAFA9"))
                    border.color: "#DEF2F1"
                    border.width: 1
                    radius: 10
                }
                onCheckStateChanged: {
                    if (leftMenuButton2.checked) {
                        mediaplayer1.source = buttonsClicked.leftMenuButtonClicked(2, leftMenu.width, topBar.height + (mainWindow.height - alignVideo.height)/2, videooutput.width, videooutput.height)
                        leftMenuButton1.enabled = false
                        leftMenuButton3.enabled = false
                        leftMenuButton4.enabled = false
                    } else {
                        mediaplayer1.source = " "
                        leftMenuButton1.enabled = true
                        leftMenuButton3.enabled = true
                        leftMenuButton4.enabled = true
                    }
                }
            }
            CheckBox {
                id: leftMenuButton3
                text: "Object Detection"
                height: parent.height * 0.1
                width: parent.width * 0.8
                anchors.top: leftMenuButton2.bottom
                anchors.topMargin: parent.height * 0.1
                anchors.horizontalCenter: parent.horizontalCenter
                indicator: Rectangle {}
                background: Rectangle {
                    id: leftMenuButton3BG
                    color: !parent.enabled ? "#17252A" : (parent.hovered ? "#84CDC9" : (parent.checkState===Qt.Checked? "#2B837F" : "#3AAFA9"))
                    border.color: "#DEF2F1"
                    border.width: 1
                    radius: 10
                }
                onCheckStateChanged: {
                    if (leftMenuButton3.checked) {
                        mediaplayer1.source = buttonsClicked.leftMenuButtonClicked(3, leftMenu.width, topBar.height + (mainWindow.height - alignVideo.height)/2, videooutput.width, videooutput.height)
                        leftMenuButton1.enabled = false
                        leftMenuButton2.enabled = false
                        leftMenuButton4.enabled = false
                    } else {
                        mediaplayer1.source = " "
                        leftMenuButton1.enabled = true
                        leftMenuButton2.enabled = true
                        leftMenuButton4.enabled = true
                    }
                }
            }
            CheckBox {
                id: leftMenuButton4
                text: "Custom"
                height: parent.height * 0.1
                width: parent.width * 0.8
                anchors.top: leftMenuButton3.bottom
                anchors.topMargin: parent.height * 0.1
                anchors.horizontalCenter: parent.horizontalCenter
                indicator: Rectangle {}
                background: Rectangle {
                    id: leftMenuButton4BG
                    color: !parent.enabled ? "#17252A" : (parent.hovered ? "#84CDC9" : (parent.checkState===Qt.Checked? "#2B837F" : "#3AAFA9"))
                    border.color: "#DEF2F1"
                    border.width: 1
                    radius: 10
                }
                onCheckStateChanged: {
                    if (leftMenuButton4.checked) {
                        popup.open()
                        leftMenuButton1.enabled = false
                        leftMenuButton2.enabled = false
                        leftMenuButton3.enabled = false
                    } else {
                        mediaplayer1.source = " "
                        leftMenuButton1.enabled = true
                        leftMenuButton2.enabled = true
                        leftMenuButton3.enabled = true
                    }
                }
            }
        }
        Rectangle {
            id: mainWindow
            color: "#17252A"
            width: parent.width * 0.825
            height: parent.height * 0.9
            anchors.top: topBar.bottom
            anchors.left: leftMenu.right
            anchors.rightMargin: parent.width * 0.025

            Rectangle {
                id: alignVideo
                width: parent.width
                height: (parent.width / 16) * 9
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: (parent.height - height) / 2
                border.color: "#DEF2F1"
                border.width: 1

                radius: 10
                color: "#17252A"

                Image {
                    width: parent.width
                    height: parent.height
                    source: "images/sk-am62-angled.png"
                }

                MediaPlayer {
                    id: mediaplayer1
                    objectName: "mediaplayer1"
                    // source: is provided by the Cpp Backend
                    autoPlay: true
                }

                VideoOutput {
                    id: videooutput
                    width: parent.width
                    height: parent.height
                    source: mediaplayer1
                    fillMode: VideoOutput.PreserveAspectCrop
                }
            }
            Popup {
                id: popup
                anchors.centerIn: parent
                onClosed: {
                    leftMenuButton4.checked = false
                }

                width: alignVideo.width * 0.6
                height: alignVideo.height * 0.6

                modal: true
                focus: true
                closePolicy: Popup.NoAutoClose

                background: Rectangle {
                    width: parent.width
                    height: parent.height
                    border.color: "#DEF2F1"
                    border.width: 10
                }

                Text {
                    id: inputTypeHead
                    text: qsTr("Input Type: ")
                    font.pointSize: 11
                    anchors.bottom: popupInputType.top
                    anchors.bottomMargin: popupInputType.height * 0.2
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width * 0.15
                }

                ComboBox {
                    id: popupInputType
                    width: parent.width * 0.3
                    anchors.top: parent.top
                    anchors.topMargin: parent.height * 0.25
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width * 0.15

                    model: ListModel {
                        id: popupInputTypeOptions
                        ListElement { name: "Image" }
                        ListElement { name: "Video" }
                        ListElement { name: "Camera" }
                    }
                    onCurrentIndexChanged: {
                        console.debug(popupInputTypeOptions.get(currentIndex))
                        popupMenu.popupInputTypeSelected(model.get(currentIndex).name)
                        if (popupInputTypeOptions.get(currentIndex).name === "Image") {
                            popupInputImages.visible = true
                            popupInputVideos.visible = false
                            popupInputCameras.visible = false
                        }
                        if (popupInputTypeOptions.get(currentIndex).name === "Video") {
                            popupInputImages.visible = false
                            popupInputVideos.visible = true
                            popupInputCameras.visible = false
                        }
                        if (popupInputTypeOptions.get(currentIndex).name === "Camera") {
                            popupInputImages.visible = false
                            popupInputVideos.visible = false
                            popupInputCameras.visible = true
                        }
                    }
                }
                Text {
                    id: inputHead
                    text: qsTr("Input: ")
                    font.pointSize: 11
                    anchors.bottom: popupInputImages.top
                    anchors.bottomMargin: popupInputImages.height * 0.2
                    anchors.left: popupInputType.right
                    anchors.leftMargin: parent.width * 0.1
                }
                ComboBox {
                    id: popupInputImages
                    visible: false
                    width: parent.width * 0.3
                    anchors.left: popupInputType.right
                    anchors.leftMargin: parent.width * 0.1
                    anchors.top: parent.top
                    anchors.topMargin: parent.height * 0.25

                    FolderListModel{
                        id: inputImagesFolder
                        folder: "file:///opt/edgeai-test-data/images/"
                        nameFilters: [ "*.jpg", "*.png" ]
                    }

                    model: inputImagesFolder
                    textRole: 'fileName'
                    onCurrentIndexChanged: {
                        console.debug(model.get(currentIndex, "filePath"))
                    }
                    onVisibleChanged: {
                        if(visible)
                            inputHead.text = qsTr("Image: ")
                    }
                }
                ComboBox {
                    id: popupInputVideos
                    visible: false
                    width: parent.width * 0.3
                    anchors.left: popupInputType.right
                    anchors.leftMargin: parent.width * 0.1
                    anchors.top: parent.top
                    anchors.topMargin: parent.height * 0.25

                    FolderListModel{
                        id: inputVideosFolder
                        folder: "file:///opt/edgeai-test-data/videos/"
                        nameFilters: [ "*.mp4", "*.h264", "*.avi" ]
                    }

                    model: inputVideosFolder
                    textRole: 'fileName'
                    onCurrentIndexChanged: {
                        console.debug(model.get(currentIndex, "filePath"))
                    }
                    onVisibleChanged: {
                        if(visible)
                            inputHead.text = qsTr("Video: ")
                    }
                }
                ComboBox {
                    id: popupInputCameras
                    visible: false
                    width: parent.width * 0.3
                    anchors.left: popupInputType.right
                    anchors.leftMargin: parent.width * 0.1
                    anchors.top: parent.top
                    anchors.topMargin: parent.height * 0.25

                    model: cameraNamesList
                    textRole: 'display'

                    onCurrentIndexChanged: {
                        console.debug(model.data(model.index(currentIndex, 0)))
                    }
                    onVisibleChanged: {
                        if(visible)
                            inputHead.text = qsTr("Camera: ")
                    }
                }
                Text {
                    id: modelHead
                    text: qsTr("Model Type: ")
                    font.pointSize: 11
                    anchors.bottom: popupModelType.top
                    anchors.bottomMargin: popupModelType.height * 0.2
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width * 0.15
                }
                ComboBox {
                    id: popupModelType
                    width: parent.width * 0.3
                    anchors.top: popupInputType.bottom
                    anchors.topMargin: parent.height * 0.1
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width * 0.15
                    model: modelsFolder
                    textRole: 'fileName'

                    FolderListModel{
                        id: modelsFolder
                        folder: "file:///opt/model_zoo/"
                    }
                    onCurrentIndexChanged: {
                        console.debug(model.get(currentIndex, "filePath"))
                    }
                }
                Button {
                    id: popupOkButton
                    text: "Start"
                    onClicked: {
                        console.log("TODO: Start Pressed. Implement the pipeline in Backend now :)")
                        popup.close()
                    }

                    width: parent.width * 0.2
                    height: parent.height * 0.075

                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: parent.height * 0.1
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width * 0.25

                    background: Rectangle {
                        color: parent.hovered ? "#3AAFA9" : "#CCCCCC"
                        radius: parent.height
                    }
                }
                Button {
                    id: popupCancelButton
                    text: "Cancel"
                    onClicked: {
                        popup.close()
                    }

                    width: parent.width * 0.2
                    height: parent.height * 0.075

                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: parent.height * 0.1
                    anchors.right: parent.right
                    anchors.rightMargin: parent.width * 0.25

                    background: Rectangle {
                        color: parent.hovered ? "#3AAFA9" : "#CCCCCC"
                        radius: parent.height
                    }
                }
            }
        }
    }
}
