import QtQml 2.1
import QtQuick 2.1
import QtMultimedia 5.1
import QtQuick.Window 2.1
import QtQuick.Controls 2.1
import QtGraphicalEffects 1.12
import Qt.labs.folderlistmodel 2.4

Window {
    visible: true
    visibility: "FullScreen"
    title: qsTr("Edge AI - UI App")

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
                height: parent.height
                width: height * 2.84 // To maintain the aspect ratio of the image
                anchors.top: parent.top
                anchors.topMargin: parent.height * 0.1
                source: "images/Texas-Instruments.png"
            }

            Text {
                id: topBarHead
                objectName: "topBarHead"
                text: qsTr("Edge AI - UI App")

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
                    color: "#FF0000"
                    radius: parent.height
                }
            }
        }
        Rectangle {
            id: leftMenu

            width: parent.width * 0.15
            height: parent.height * 0.85
            anchors.top: topBar.bottom
            anchors.left: parent.left

            color: "#17252A"

            Rectangle {
                id: leftSubMenu

                width: parent.width * 0.9
                height: parent.height * 0.6
                anchors.horizontalCenter: leftMenu.horizontalCenter
                anchors.verticalCenter: leftMenu.verticalCenter
                color: "#344045"

                border.color: "#DEF2F1"
                border.width: 1
                radius: 10

                CheckBox {
                    id: leftMenuButton1
                    text: "Image Classification"
                    font.bold: true
                    font.pointSize: 13
                    height: parent.height * 0.5 / 3
                    width: parent.width * 0.85
                    anchors.top: parent.top
                    anchors.topMargin: parent.height * 0.2 / 3
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
                            mediaplayer1.source = backend.leftMenuButtonPressed(1, leftMenu.width, topBar.height + (mainWindow.height - alignVideo.height)/2, videooutput.width, videooutput.height)
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
                    text: "Object Detection"
                    font.bold: true
                    font.pointSize: 13
                    height: parent.height * 0.5 / 3
                    width: parent.width * 0.85
                    anchors.top: leftMenuButton1.bottom
                    anchors.topMargin: parent.height * 0.2 / 3
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
                            mediaplayer1.source = backend.leftMenuButtonPressed(2, leftMenu.width, topBar.height + (mainWindow.height - alignVideo.height)/2, videooutput.width, videooutput.height)
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
                    text: "Semantic Segmentation"
                    font.bold: true
                    font.pointSize: 13
                    height: parent.height * 0.5 / 3
                    width: parent.width * 0.85
                    anchors.top: leftMenuButton2.bottom
                    anchors.topMargin: parent.height * 0.2 / 3
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
                            mediaplayer1.source = backend.leftMenuButtonPressed(3, leftMenu.width, topBar.height + (mainWindow.height - alignVideo.height)/2, videooutput.width, videooutput.height)
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
                    font.bold: true
                    font.pointSize: 13
                    height: parent.height * 0.5 / 3
                    width: parent.width * 0.85
                    anchors.top: leftMenuButton3.bottom
                    anchors.topMargin: parent.height * 0.2 / 3
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
                            popupError.text = " "
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
        }
        Rectangle {
            id: mainWindow
            color: "#17252A"
            width: parent.width * 0.825
            height: parent.height * 0.85
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
                    source: "images/wallpaper.jpg"
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

                width: alignVideo.width * 0.3
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
                    anchors.centerIn: popup.Center
                    anchors.bottom: popupInputType.top
                    anchors.bottomMargin: popupInputType.height * 0.2
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width * 0.2
                }

                ComboBox {
                    id: popupInputType
                    width: parent.width * 0.6
                    height: parent.height * 0.1
                    anchors.top: parent.top
                    anchors.topMargin: parent.height * 0.175
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width * 0.2

                    model: ListModel {
                        id: popupInputTypeOptions
                        ListElement { Text: "Image" }
                        ListElement { Text: "Video" }
                        ListElement { Text: "Camera" }
                    }
                    onCurrentIndexChanged: {
                        if (popupInputTypeOptions.get(currentIndex).Text === "Image") {
                            popupInputImages.visible = true
                            popupInputVideos.visible = false
                            popupInputCameras.visible = false
                        }
                        if (popupInputTypeOptions.get(currentIndex).Text === "Video") {
                            popupInputImages.visible = false
                            popupInputVideos.visible = true
                            popupInputCameras.visible = false
                        }
                        if (popupInputTypeOptions.get(currentIndex).Text === "Camera") {
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
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width * 0.2
                }
                Text {
                    id: inputPath
                    text: qsTr(" ")
                    color: "#888888"
                    font.pointSize: 11
                    anchors.bottom: popupInputImages.top
                    anchors.bottomMargin: popupInputImages.height * 0.2
                    anchors.left: inputHead.right
                    anchors.leftMargin: inputHead.width * 0.2
                }
                ComboBox {
                    id: popupInputImages
                    visible: false
                    width: parent.width * 0.6
                    height: parent.height * 0.1
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width * 0.2
                    anchors.top: popupInputType.bottom
                    anchors.topMargin: parent.height * 0.1

                    FolderListModel{
                        id: inputImagesFolder
                        folder: "file:///opt/edgeai-test-data/images/"
                        nameFilters: [ "*.jpg", "*.png" ]
                    }

                    model: inputImagesFolder
                    textRole: 'fileName'
                    onVisibleChanged: {
                        if(visible) {
                            inputHead.text = qsTr("Image:")
                            inputPath.text = qsTr("/opt/edgeai-test-data/images/")
                        }
                    }
                }
                ComboBox {
                    id: popupInputVideos
                    visible: false
                    width: parent.width * 0.6
                    height: parent.height * 0.1
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width * 0.2
                    anchors.top: popupInputType.bottom
                    anchors.topMargin: parent.height * 0.1

                    FolderListModel{
                        id: inputVideosFolder
                        folder: "file:///opt/edgeai-test-data/videos/"
                        nameFilters: [ "*.mp4", "*.h264", "*.avi" ]
                    }

                    model: inputVideosFolder
                    textRole: 'fileName'
                    onVisibleChanged: {
                        if(visible) {
                            inputHead.text = qsTr("Video:")
                            inputPath.text = qsTr("/opt/edgeai-test-data/videos/")
                        }
                    }
                }
                ComboBox {
                    id: popupInputCameras
                    visible: false
                    width: parent.width * 0.6
                    height: parent.height * 0.1
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width * 0.2
                    anchors.top: popupInputType.bottom
                    anchors.topMargin: parent.height * 0.1

                    model: cameraNamesList
                    textRole: 'display'
                    onVisibleChanged: {
                        if(visible) {
                            inputHead.text = qsTr("Camera: ")
                            inputPath.text = qsTr(" ")
                        }
                    }
                }
                Text {
                    id: modelHead
                    text: qsTr("Model: ")
                    font.pointSize: 11
                    anchors.bottom: popupModel.top
                    anchors.bottomMargin: popupModel.height * 0.2
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width * 0.2
                }
                ComboBox {
                    id: popupModel
                    width: parent.width * 0.6
                    height: parent.height * 0.1
                    anchors.top: popupInputImages.bottom
                    anchors.topMargin: parent.height * 0.1
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width * 0.2
                    model: modelsFolder
                    textRole: 'fileName'

                    FolderListModel{
                        id: modelsFolder
                        folder: "file:///opt/model_zoo/"
                        showFiles: false
                    }
                }
                Text {
                    id: popupError
                    text: " "
                    color: "#FF0000"
                    font.pointSize: 11
                    anchors.top: popupModel.bottom
                    anchors.topMargin: parent.height * 0.05
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width * 0.2
                }

                Button {
                    id: popupOkButton
                    text: "Start"
                    onClicked: {
                        popupError.text = "Loading ..."
                        var inputType = popupInputType.model.get(popupInputType.currentIndex).Text
                        var inputFile
                        var modelFile
                        if (popupInputType.model.get(popupInputType.currentIndex).Text === "Image")
                            inputFile = popupInputImages.model.get(popupInputImages.currentIndex, "filePath")
                        if (popupInputType.model.get(popupInputType.currentIndex).Text === "Video")
                            inputFile = popupInputVideos.model.get(popupInputVideos.currentIndex, "filePath")
                        if (popupInputType.model.get(popupInputType.currentIndex).Text === "Camera")
                            inputFile = popupInputCameras.model.data(popupInputCameras.model.index(popupInputCameras.currentIndex, 0))

                        modelFile = popupModel.model.get(popupModel.currentIndex, "filePath")

                        if((inputFile === undefined) || (modelFile === undefined)) {
                            popupError.text = "Invalid Inputs!"
                        } else {
                            popupError.text = "Loading ..."
                            // Send userdata to CPP
                            mediaplayer1.source = backend.popupOkPressed(inputType, inputFile, modelFile,
                                                                           leftMenu.width, topBar.height + (mainWindow.height - alignVideo.height)/2,
                                                                           videooutput.width, videooutput.height)
                            popup.close()
                        }
                    }

                    width: parent.width * 0.2
                    height: parent.height * 0.075

                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: parent.height * 0.125
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
                        leftMenuButton4.checked = false
                    }

                    width: parent.width * 0.2
                    height: parent.height * 0.075

                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: parent.height * 0.125
                    anchors.right: parent.right
                    anchors.rightMargin: parent.width * 0.25

                    background: Rectangle {
                        color: parent.hovered ? "#3AAFA9" : "#CCCCCC"
                        radius: parent.height
                    }
                }
            }
        }
        Rectangle {
            id: deviceInfo
            anchors.left: parent.left
            anchors.right: mainWindow.right
            anchors.top: mainWindow.bottom
            anchors.bottom: parent.bottom
            color: "#17252A"
            Text {
                id: ipAddr
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right

                text: backend.ip_addr
                color: "#FEFFFF"
                font.pointSize: 15
            }
        }
    }
}
