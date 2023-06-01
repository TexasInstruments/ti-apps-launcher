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
Window {
    visible: true
    visibility: "FullScreen"
    title: qsTr("Edge AI gallery")

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
                text: qsTr("Edge AI gallery")

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
                onClicked: Qt.quit()
                height: parent.height * 0.2
                width: height

                anchors.right: parent.right
                anchors.rightMargin: width * 0.5
                anchors.top: parent.top
                anchors.topMargin: height * 0.5

                background: Rectangle {
                    Text {
                        text: "×"
                        font.pointSize: 12
                        color: "#FEFFFF"
                        anchors.centerIn: parent
                        font.bold: true
                    }
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
                    text: "Industrial Control"
                    font.bold: true
                    font.pointSize: 13
                    height: parent.height * 0.1
                    width: parent.width * 0.85
                    anchors.top: parent.top
                    anchors.topMargin: parent.height * 0.04
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
                        //mediaplayer1.source = backend.leftMenuButtonPressed(1, leftMenu.width + (alignVideo.border.width * 2), topBar.height + ((mainWindow.height - alignVideo.height)/2) + (alignVideo.border.width * 2), videooutput.width, videooutput.height)
                         //   leftMenuButton1.enabled = false
                            leftMenuButton2.enabled = false
                            leftMenuButton3.enabled = false
                            leftMenuButton4.enabled = false
                            leftMenuButton5.enabled = false
                            leftMenuButton6.enabled = false
                            leftMenuButton7.enabled = false

                            mainimg.visible = false
                            window.visible = true
                            
                        } else {
                            mediaplayer1.source = " "
                         //   leftMenuButton1.enabled = true
                            leftMenuButton2.enabled = true
                            leftMenuButton3.enabled = true
                            leftMenuButton4.enabled = true
                            leftMenuButton5.enabled = true
                            leftMenuButton6.enabled = true
                            leftMenuButton7.enabled = true

                            mainimg.visible = true
                            window.visible = false
                        }
                    }
                }

                CheckBox {
                    id: leftMenuButton2
                    text: "Camera Recorder"
                    font.bold: true
                    font.pointSize: 13
                    height: parent.height * 0.1
                    width: parent.width * 0.85
                    anchors.top: leftMenuButton1.bottom
                    anchors.topMargin: parent.height * 0.04
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
                            mediaplayer1.source = backend.leftMenuButtonPressed(2, leftMenu.width + (alignVideo.border.width * 2), topBar.height + ((mainWindow.height - alignVideo.height)/2) + (alignVideo.border.width * 2), videooutput.width, videooutput.height)
                            leftMenuButton1.enabled = false
                         //   leftMenuButton2.enabled = false
                            leftMenuButton3.enabled = false
                            leftMenuButton4.enabled = false
                            leftMenuButton5.enabled = false
                            leftMenuButton6.enabled = false
                            leftMenuButton7.enabled = false
                             videoOutput.visible = true
                        } else {
                            mediaplayer1.source = " "
                            leftMenuButton1.enabled = true
                         //   leftMenuButton2.enabled = true
                            leftMenuButton3.enabled = true
                            leftMenuButton4.enabled = true
                            leftMenuButton5.enabled = true
                            leftMenuButton6.enabled = true
                            leftMenuButton7.enabled = true

                            videoOutput.visibile = false
                        }
                    }
                }
                CheckBox {
                    id: leftMenuButton3
                    text: "Benchmarks"
                    font.bold: true
                    font.pointSize: 13
                    height: parent.height * 0.1
                    width: parent.width * 0.85
                    anchors.top: leftMenuButton2.bottom
                    anchors.topMargin: parent.height * 0.04
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
                            mediaplayer1.source = backend.leftMenuButtonPressed(3, leftMenu.width + (alignVideo.border.width * 2), topBar.height + ((mainWindow.height - alignVideo.height)/2) + (alignVideo.border.width * 2), videooutput.width, videooutput.height)
                            leftMenuButton1.enabled = false
                            leftMenuButton2.enabled = false
                          //  leftMenuButton3.enabled = false
                            leftMenuButton4.enabled = false
                            leftMenuButton5.enabled = false
                            leftMenuButton6.enabled = false
                            leftMenuButton7.enabled = false

                            benchmarkswindow.visible = true
                        } else {
                            mediaplayer1.source = " "
                            leftMenuButton1.enabled = true
                            leftMenuButton2.enabled = true
                          //  leftMenuButton3.enabled = true
                            leftMenuButton4.enabled = true
                            leftMenuButton5.enabled = true
                            leftMenuButton6.enabled = true
                            leftMenuButton7.enabled = true

                            benchmarkswindow.visible = false
                        }
                    }
                }
                CheckBox {
                    id: leftMenuButton4
                    text: "GPU Performance"
                    font.bold: true
                    font.pointSize: 13
                    height: parent.height * 0.1
                    width: parent.width * 0.85
                    anchors.top: leftMenuButton3.bottom
                    anchors.topMargin: parent.height * 0.04
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
                        //    leftMenuButton4.enabled = false
                            leftMenuButton5.enabled = false
                            leftMenuButton6.enabled = false
                            leftMenuButton7.enabled = false
                        } else {
                            mediaplayer1.source = " "
                            leftMenuButton1.enabled = true
                            leftMenuButton2.enabled = true
                            leftMenuButton3.enabled = true
                          //  leftMenuButton4.enabled = true
                            leftMenuButton5.enabled = true
                            leftMenuButton6.enabled = true
                            leftMenuButton7.enabled = true
                        }
                    }
                }
                CheckBox {
                    id: leftMenuButton5
                    text: "Multi Cam"
                    font.bold: true
                    font.pointSize: 13
                    height: parent.height * 0.1
                    width: parent.width * 0.85
                    anchors.top: leftMenuButton4.bottom
                    anchors.topMargin: parent.height * 0.04
                    anchors.horizontalCenter: parent.horizontalCenter
                    indicator: Rectangle {}
                    background: Rectangle {
                        id: leftMenuButton5BG
                        color: !parent.enabled ? "#17252A" : (parent.hovered ? "#84CDC9" : (parent.checkState===Qt.Checked? "#2B837F" : "#3AAFA9"))
                        border.color: "#DEF2F1"
                        border.width: 1
                        radius: 10
                    }
                    onCheckStateChanged: {
                        if (leftMenuButton5.checked) {
                            mediaplayer1.source = backend.leftMenuButtonPressed(3, leftMenu.width + (alignVideo.border.width * 2), topBar.height + ((mainWindow.height - alignVideo.height)/2) + (alignVideo.border.width * 2), videooutput.width, videooutput.height)
                            leftMenuButton1.enabled = false
                            leftMenuButton2.enabled = false
                            leftMenuButton3.enabled = false
                            leftMenuButton4.enabled = false
                          //  leftMenuButton5.enabled = false
                            leftMenuButton6.enabled = false
                            leftMenuButton7.enabled = false
                        } else {
                            mediaplayer1.source = " "
                            leftMenuButton1.enabled = true
                            leftMenuButton2.enabled = true
                            leftMenuButton3.enabled = true
                            leftMenuButton4.enabled = true
                          //  leftMenuButton5.enabled = true
                            leftMenuButton6.enabled = true
                            leftMenuButton7.enabled = true
                        }
                    }
                }
                CheckBox {
                    id: leftMenuButton6
                    text: "Multi Display"
                    font.bold: true
                    font.pointSize: 13
                    height: parent.height * 0.1
                    width: parent.width * 0.85
                    anchors.top: leftMenuButton5.bottom
                    anchors.topMargin: parent.height * 0.04
                    anchors.horizontalCenter: parent.horizontalCenter
                    indicator: Rectangle {}
                    background: Rectangle {
                        id: leftMenuButton6BG
                        color: !parent.enabled ? "#17252A" : (parent.hovered ? "#84CDC9" : (parent.checkState===Qt.Checked? "#2B837F" : "#3AAFA9"))
                        border.color: "#DEF2F1"
                        border.width: 1
                        radius: 10
                    }
                    onCheckStateChanged: {
                        if (leftMenuButton6.checked) {
                            mediaplayer1.source = backend.leftMenuButtonPressed(3, leftMenu.width + (alignVideo.border.width * 2), topBar.height + ((mainWindow.height - alignVideo.height)/2) + (alignVideo.border.width * 2), videooutput.width, videooutput.height)
                            leftMenuButton1.enabled = false
                            leftMenuButton2.enabled = false
                            leftMenuButton3.enabled = false
                            leftMenuButton4.enabled = false
                            leftMenuButton5.enabled = false
                          //  leftMenuButton6.enabled = false
                            leftMenuButton7.enabled = false
                        } else {
                            mediaplayer1.source = " "
                            leftMenuButton1.enabled = true
                            leftMenuButton2.enabled = true
                            leftMenuButton3.enabled = true
                            leftMenuButton4.enabled = true
                            leftMenuButton5.enabled = true
                           // leftMenuButton6.enabled = true
                            leftMenuButton7.enabled = true
                        }
                    }
                }
                CheckBox {
                    id: leftMenuButton7
                    text: "Chromium"
                    font.bold: true
                    font.pointSize: 13
                    height: parent.height * 0.1
                    width: parent.width * 0.85
                    anchors.top: leftMenuButton6.bottom
                    anchors.topMargin: parent.height * 0.04
                    anchors.horizontalCenter: parent.horizontalCenter
                    indicator: Rectangle {}
                    background: Rectangle {
                        id: leftMenuButton7BG
                        color: !parent.enabled ? "#17252A" : (parent.hovered ? "#84CDC9" : (parent.checkState===Qt.Checked? "#2B837F" : "#3AAFA9"))
                        border.color: "#DEF2F1"
                        border.width: 1
                        radius: 10
                    }
                    onCheckStateChanged: {
                        if (leftMenuButton7.checked) {
                            mediaplayer1.source = backend.leftMenuButtonPressed(3, leftMenu.width + (alignVideo.border.width * 2), topBar.height + ((mainWindow.height - alignVideo.height)/2) + (alignVideo.border.width * 2), videooutput.width, videooutput.height)
                            leftMenuButton1.enabled = false
                            leftMenuButton2.enabled = false
                            leftMenuButton3.enabled = false
                            leftMenuButton4.enabled = false
                            leftMenuButton5.enabled = false
                            leftMenuButton6.enabled = false
                          //  leftMenuButton7.enabled = false
                        } else {
                            mediaplayer1.source = " "
                            leftMenuButton1.enabled = true
                            leftMenuButton2.enabled = true
                            leftMenuButton3.enabled = true
                            leftMenuButton4.enabled = true
                            leftMenuButton5.enabled = true
                            leftMenuButton6.enabled = true
                           // leftMenuButton7.enabled = true
                        }
                    }
                }
            }
        }
        Rectangle {
            id: mainWindow
            color: "#17252A"
            width: parent.width * 0.825
            height: parent.height * 0.6
            anchors.top: topBar.bottom
            anchors.left: leftMenu.right
            anchors.rightMargin: parent.width * 0.025
        

            Rectangle {
                id: alignVideo
                width: parent.width
                height: (parent.width / 16) * 9
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                //anchors.topMargin: (parent.height - height) / 2
                border.color: "#DEF2F1"
                border.width: 3

                radius: 10
                color: "#17252A"

                Image {
                    id:mainimg
                    visible: true
                    width: parent.width
                    height: parent.height
                    source: "file://opt/oob-demo-assets/wallpaper.jpg"
                    anchors.fill: parent
                    anchors.margins: parent.border.width * 2
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
                    anchors.fill: parent
                    anchors.margins: parent.border.width * 2
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
                    text: qsTr("Model:")
                    font.pointSize: 11
                    anchors.bottom: popupModel.top
                    anchors.bottomMargin: popupModel.height * 0.2
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width * 0.2
                }
                Text {
                    id: modelPath
                    text: qsTr("/opt/model_zoo/")
                    color: "#888888"
                    font.pointSize: 11
                    anchors.bottom: popupModel.top
                    anchors.bottomMargin: popupModel.height * 0.2
                    anchors.left: modelHead.right
                    anchors.leftMargin: modelHead.width * 0.2
                }

                ComboBox {
                    id: popupModel
                    width: parent.width * 0.6
                    height: parent.height * 0.1
                    anchors.top: popupInputImages.bottom
                    anchors.topMargin: parent.height * 0.1
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width * 0.2
                    model: modelNamesList
                    textRole: 'display'
                }
                Text {
                    id: popupError
                    text: " "
                    color: "#FF0000"
                    font.pointSize: 11
                    anchors.top: popupModel.bottom
                    anchors.topMargin: parent.height * 0.025
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

                        modelFile = "/opt/model_zoo/" + popupModel.model.data(popupModel.model.index(popupModel.currentIndex, 0))

                        if((inputFile === undefined) || (modelFile === undefined)) {
                            popupError.text = "Invalid Inputs!"
                        } else {
                            popupError.text = "Loading ..."
                            // Send userdata to CPP
                            mediaplayer1.source = backend.popupOkPressed(inputType, inputFile, modelFile,
                                                                           leftMenu.width + (alignVideo.border.width * 2), topBar.height + ((mainWindow.height - alignVideo.height)/2) + (alignVideo.border.width * 2),
                                                                           videooutput.width, videooutput.height)
                            popup.close()
                        }
                    }

                    width: parent.width * 0.2
                    height: parent.height * 0.075

                    anchors.top: popupError.bottom
                    anchors.topMargin: parent.height * 0.025
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

                    anchors.top: popupError.bottom
                    anchors.topMargin: parent.height * 0.025
                    anchors.right: parent.right
                    anchors.rightMargin: parent.width * 0.25

                    background: Rectangle {
                        color: parent.hovered ? "#3AAFA9" : "#CCCCCC"
                        radius: parent.height
                    }
                }
                Text {
                    id: popupNote
                    text: "Note: Models may take time to load after you click 'Start'. So please wait for few seconds!"
                    font.pointSize: 10
                    font.bold: true
                    color: "#2B837F"
                    width: parent.width * 0.8
                    anchors.top: popupCancelButton.bottom
                    anchors.topMargin: parent.height * 0.05
                    wrapMode: Text.WordWrap
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
            Rectangle {
                id: window
                width: parent.width
                height: parent.height
                anchors.top: parent.top
                anchors.left: parent.left  
                property int count: 0
                visible: false
                Image {
                    id: backgroundimage
                    source:"images/Background.png"
                    width: parent.width
                    height: parent.height
                }
                Image {
                    id: motorimage
                    source: "images/servo-drives-icon.png"
                    fillMode: Image.PreserveAspectFit
                    anchors.left: parent.left
                    anchors.leftMargin: window.width * 0.02
                    anchors.right: parent.right
                    anchors.rightMargin: window.width * 0.87
                    anchors.top: parent.top
                    anchors.topMargin: window.height * 0.01
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: window.height * 0.80
                }
                Image {
                    id: toprb
                    source: "images/Top_Righ_Box.png"
                    anchors.top: parent.top
                    anchors.topMargin: window.height * 0.15
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: window.height * 0.47
                    anchors.right: parent.right
                    anchors.rightMargin: window.width * 0.09
                    anchors.left: parent.left
                    anchors.leftMargin: window.width * 0.62

                    Text {
                        text: qsTr("Motor-1 RPM Control")
                        color: "#FFFFFF"
                        anchors.top: parent.top
                        anchors.topMargin: window.height * 0.02
                        anchors.left: parent.left
                        anchors.leftMargin: window.width * 0.075
                        font.pixelSize: parent.width * 0.05
                    }

                    CircularGauge {
                        id: motorspeed1
                        maximumValue: 130
                        anchors.top: parent.top
                        anchors.topMargin: window.height * 0.07
                        anchors.left: parent.left
                        anchors.leftMargin: window.width * 0.03
                        width: window.width * 0.22
                        height: window.height * 0.22
                        property int count1: 0
                        value: count1
                        Behavior on value {
                            NumberAnimation {
                                duration: 200
                            }
                        }
                        Component.onCompleted: forceActiveFocus()

                        style: CircularGaugeStyle {
                            needle: Rectangle {
                                implicitWidth: outerRadius * 0.02
                                implicitHeight: outerRadius * 0.60
                                antialiasing: true
                                color: "#D0001C"
                            }
                            foreground: Item {
                                Rectangle {
                                    width: outerRadius * 0.1
                                    height: width
                                    radius: width / 2
                                    color: "#FFFFFF"
                                    anchors.centerIn: parent
                                }
                            }
                            tickmarkLabel:  Text {
                                visible: false
                            }

                            tickmark: Rectangle {
                                visible: false
                            }

                            minorTickmark: Rectangle {
                                visible: false
                            }

                            function degreesToRadians(degrees) {
                                return degrees * (Math.PI / 180);
                            }
                            background: Canvas {
                                onPaint: {
                                    var ctx = getContext("2d");
                                    ctx.reset();

                                    ctx.beginPath();
                                    ctx.strokeStyle = "#C6C6C6";
                                    ctx.lineWidth = outerRadius * 0.04;

                                    ctx.arc(outerRadius, outerRadius, outerRadius - ctx.lineWidth / 2,
                                            degreesToRadians(valueToAngle(0) - 90), degreesToRadians(valueToAngle(130) - 90));
                                    ctx.stroke();
                                }
                            }
                        }       
                    }


                    Image {
                        id: rectbox1
                        source: "images/Rectangle.png"
                        anchors.top: parent.top
                        anchors.topMargin: parent.height * 0.75
                        anchors.left: parent.left
                        anchors.leftMargin: parent.width * 0.33
                        width: parent.width * 0.31
                        height: parent.height * 0.12
                        Text {
                            id: motor1text
                            text: qsTr("0")
                            color: "#FFFFFF"
                            font.pixelSize: parent.width * 0.20
                            anchors.centerIn: parent
                        }   
                        Image {
                            id: minusbox1
                            source: "images/Minux_Box.png"
                            fillMode: Image.PreserveAspectFit
                            width: parent.height
                            height: parent.height
                            x: 0
                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    if (window.count == 1) {
                                        motorspeed1.count1 -=10
                                        if ( motorspeed1.count1 == 10) {
                                            motor1bar.width = window.width * 0.01
                                            motor1text.text = motorspeed1.count1
                                        }
                                        else if (motorspeed1.count1 >= 10 && motorspeed1.count1 < 50) {
                                            motor1bar.width -= window.width * 0.025
                                            motor1text.text = motorspeed1.count1
                                        }
                                        else if (motorspeed1.count1 >= 50 && motorspeed1.count1 < 70) {
                                            motor1bar.width -= window.width * 0.03
                                            motor1text.text = motorspeed1.count1
                                        }
                                        else if (motorspeed1.count1 >= 70 && motorspeed1.count1 < 100) {
                                            motor1bar.width -= window.width * 0.025
                                            motor1text.text = motorspeed1.count1
                                        }
                                        else if (motorspeed1.count1 >= 100 && motorspeed1.count1 < 130) {
                                            motor1bar.width -= window.width * 0.03
                                            motor1text.text = motorspeed1.count1
                                        }
                                        else if (motorspeed1.count1 >= 130) {
                                            motor1bar.width = window.width * 0.34
                                            motorspeed1.count1 = 130
                                            motor1text.text = motorspeed1.count1
                                        }
                                        else {
                                            motor1bar.width = 0
                                            motorspeed1.count1 = 0
                                            motor1text.text = motorspeed1.count1
                                        }
                                    }
                                }
                            }
                        }
                        Image {
                            id: plusbox1
                            source: "images/Plus_Box.png"
                            fillMode: Image.PreserveAspectFit
                            width: parent.height
                            height: parent.height
                            x: parent.width * 0.72
                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    if (window.count == 1) {
                                        motorspeed1.count1 +=10
                                        if ( motorspeed1.count1 == 10) {
                                            motor1bar.width = window.width * 0.01
                                            motor1text.text = motorspeed1.count1
                                        }
                                        else if (motorspeed1.count1 >= 10 && motorspeed1.count1 < 50) {
                                            motor1bar.width += window.width * 0.025
                                            motor1text.text = motorspeed1.count1
                                        }
                                        else if (motorspeed1.count1 >= 50 && motorspeed1.count1 < 70) {
                                            motor1bar.width += window.width * 0.03
                                            motor1text.text = motorspeed1.count1
                                        }
                                        else if (motorspeed1.count1 >= 70 && motorspeed1.count1 < 100) {
                                            motor1bar.width += window.width * 0.025
                                            motor1text.text = motorspeed1.count1
                                        }
                                        else if (motorspeed1.count1 >= 100 && motorspeed1.count1 < 130) {
                                            motor1bar.width += window.width * 0.03
                                            motor1text.text = motorspeed1.count1
                                        }
                                        else if (motorspeed1.count1 >= 130) {
                                            motor1bar.width = window.width * 0.34
                                            motorspeed1.count1 = 130
                                            motor1text.text = motorspeed1.count1
                                        }

                                        else {
                                            motor1bar.width = 0
                                            motorspeed1.count1 = 0
                                            motor1text.text = motorspeed1.count1
                                        }
                                    }
                                    else {
                                        textupdate.text = "Press the ON button to start Motor-1 control"
                                    }
                                }
                            }
                        }
                    }
                }
                Image {
                    id: bottomrb
                    source: "images/Bottom_Right_Box.png"
                    anchors.top: parent.top
                    anchors.topMargin: window.height * 0.53
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: window.height * 0.09
                    anchors.right: parent.right
                    anchors.rightMargin: window.width * 0.09
                    anchors.left: parent.left
                    anchors.leftMargin: window.width * 0.62

                    Text {
                        text: qsTr("Motor-2 RPM Control")
                        color: "#FFFFFF"
                        anchors.top: parent.top
                        anchors.topMargin: window.height * 0.02
                        anchors.left: parent.left
                        anchors.leftMargin: window.width * 0.075
                        font.pixelSize: parent.width * 0.05
                    }
                    CircularGauge {
                        id: motorspeed2
                        maximumValue: 130
                        anchors.top: parent.top
                        anchors.topMargin: window.height * 0.07
                        anchors.left: parent.left
                        anchors.leftMargin: window.width * 0.03
                        width: window.width * 0.22
                        height: window.height * 0.22
                        property int count2: 0
                        value: count2
                        Behavior on value {
                            NumberAnimation {
                                duration: 200
                            }
                        }
                        style: CircularGaugeStyle {
                            needle: Rectangle {
                                implicitWidth: outerRadius * 0.02
                                implicitHeight: outerRadius * 0.60
                                antialiasing: true
                                color: "#D0001C"
                            }
                            foreground: Item {
                                Rectangle {
                                    width: outerRadius * 0.1
                                    height: width
                                    radius: width / 2
                                    color: "#FFFFFF"
                                    anchors.centerIn: parent
                                }
                            }
                            tickmarkLabel:  Text {
                                visible: false
                            }

                            tickmark: Rectangle {
                                visible: false
                            }

                            minorTickmark: Rectangle {
                                visible: false
                            }

                            function degreesToRadians(degrees) {
                                return degrees * (Math.PI / 180);
                            }
                            background: Canvas {
                                onPaint: {
                                    var ctx = getContext("2d");
                                    ctx.reset();

                                    ctx.beginPath();
                                    ctx.strokeStyle = "#C6C6C6";
                                    ctx.lineWidth = outerRadius * 0.04;

                                    ctx.arc(outerRadius, outerRadius, outerRadius - ctx.lineWidth / 2,
                                            degreesToRadians(valueToAngle(0) - 90), degreesToRadians(valueToAngle(130) - 90));
                                    ctx.stroke();
                                }
                            }
                        }
                    }
                    Image {
                        id: rectbox2
                        source: "images/Rectangle.png"
                        anchors.top: parent.top
                        anchors.topMargin: parent.height * 0.75
                        anchors.left: parent.left
                        anchors.leftMargin: parent.width * 0.33
                        width: parent.width * 0.31
                        height: parent.height * 0.12
                        Text {
                            id: motor2text
                            text: qsTr("0")
                            color: "#FFFFFF"
                            font.pixelSize: parent.width * 0.20
                            anchors.centerIn: parent
                        }
                        Image {
                            id: minusbox2
                            source: "images/Minux_Box.png"
                            fillMode: Image.PreserveAspectFit
                            width: parent.height
                            height: parent.height
                            x: 0
                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    if (window.count == 1) {
                                        motorspeed2.count2 -=10
                                        if ( motorspeed2.count2 == 10) {
                                            motor2bar.width = window.width * 0.01
                                            motor2text.text = motorspeed2.count2
                                        }
                                        else if (motorspeed2.count2 >= 10 && motorspeed2.count2 < 50) {
                                            motor2bar.width -= window.width * 0.025
                                            motor2text.text = motorspeed2.count2
                                        }
                                        else if (motorspeed2.count2 >= 50 && motorspeed2.count2 < 70) {
                                            motor2bar.width -= window.width * 0.03
                                            motor2text.text = motorspeed2.count2
                                        }
                                        else if (motorspeed2.count2 >= 70 && motorspeed2.count2 < 100) {
                                            motor2bar.width -= window.width * 0.025
                                            motor2text.text = motorspeed2.count2
                                        }
                                        else if (motorspeed2.count2 >= 100 && motorspeed2.count2 < 130) {
                                            motor2bar.width -= window.width * 0.03
                                            motor2text.text = motorspeed2.count2
                                        }
                                        else if (motorspeed2.count2 >= 130) {
                                            motor2bar.width = window.width * 0.34
                                            motorspeed2.count2 = 130
                                            motor2text.text = motorspeed2.count2
                                        }
                                        else {
                                            motor2bar.width = 0
                                            motorspeed2.count2 = 0
                                            motor2text.text = motorspeed2.count2
                                        }
                                    }
                                }
                            }
                        }
                        Image {
                            id: plusbox2
                            source: "images/Plus_Box.png"
                            fillMode: Image.PreserveAspectFit
                            width: parent.height
                            height: parent.height
                            x: parent.width * 0.72
                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    if (window.count == 1) {
                                        motorspeed2.count2 +=10
                                        if ( motorspeed2.count2 == 10) {
                                            motor2bar.width = window.width * 0.01
                                            motor2text.text = motorspeed2.count2
                                        }
                                        else if (motorspeed2.count2 >= 10 && motorspeed2.count2 < 50) {
                                            motor2bar.width += window.width * 0.025
                                            motor2text.text = motorspeed2.count2
                                        }
                                        else if (motorspeed2.count2 >= 50 && motorspeed2.count2 < 70) {
                                            motor2bar.width += window.width * 0.03
                                            motor2text.text = motorspeed2.count2
                                        }
                                        else if (motorspeed2.count2 >= 70 && motorspeed2.count2 < 100) {
                                            motor2bar.width += window.width * 0.025
                                            motor2text.text = motorspeed2.count2
                                        }
                                        else if (motorspeed2.count2 >= 100 && motorspeed2.count2 < 130) {
                                            motor2bar.width += window.width * 0.03
                                            motor2text.text = motorspeed2.count2
                                        }
                                        else if (motorspeed2.count2 >= 130) {
                                            motor2bar.width = window.width * 0.34
                                            motorspeed2.count2 = 130
                                            motor2text.text = motorspeed2.count2
                                        }
                                        else {
                                            motor2bar.width = 0
                                            motorspeed2.count2 = 0
                                            motor2text.text = motorspeed2.count2
                                        }
                                    }
                                    else {
                                        textupdate.text = "Press the ON button to start Motor-2 control"
                                    }
                                }
                            }
                        }
                    }
                }
                Image {
                    id: centreb
                    source: "images/Center_Box.png"
                    anchors.top: parent.top
                    anchors.topMargin: window.height * 0.15
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: window.height * 0.09
                    anchors.right: parent.right
                    anchors.rightMargin: window.width * 0.38
                    anchors.left: parent.left
                    anchors.leftMargin: window.width * 0.15
                    Image {
                        source: "images/Motor_Temp.png"
                        fillMode: Image.PreserveAspectFit
                        anchors.top: parent.top
                        anchors.topMargin: window.height * 0.03
                        anchors.left: parent.left
                        anchors.leftMargin: window.width * 0.06
                        anchors.right: parent.right
                        anchors.rightMargin: window.width * 0.22
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: window.height * 0.65
                    }
                    Image {
                        id: motor1image
                        Text {
                            id: motor1
                            text: qsTr("Motor 1")
                            y: -1 * parent.height * 1.2
                            color: "#FFFFFF"
                            font.pixelSize: parent.width * 0.04
                        }
                        source: "images/Repeat_Grid.png"
                        fillMode: Image.PreserveAspectFit
                        anchors.top: parent.top
                        anchors.topMargin: window.height * 0.25
                        anchors.left: parent.left
                        anchors.leftMargin: window.width * 0.06
                        anchors.right: parent.right
                        anchors.rightMargin: window.width * 0.07
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: window.height * 0.45
                        Rectangle {

                            id: motor1tempbar
                            width: motor1image.width
                            height: motor1image.width * 0.05
                            color: "#A0A0A0"
                            anchors.top: motor1.bottom
                            anchors.topMargin: window.height * 0.02
                            Rectangle {
                                id: motor1bar
                                color: "#FFFFFF"
                                width: 0
                                height: parent.height
                            }
                        }
                    }
                    Image {
                        id: motor2image
                        Text {
                            id: motor2
                            text: qsTr("Motor 2")
                            y: -1 * parent.height * 1.2
                            color: "#FFFFFF"
                            font.pixelSize: parent.width * 0.04
                        }
                        source: "images/Repeat_Grid.png"
                        fillMode: Image.PreserveAspectFit
                        anchors.top: parent.top
                        anchors.topMargin: window.height * 0.50
                        anchors.left: parent.left
                        anchors.leftMargin: window.width * 0.06
                        anchors.right: parent.right
                        anchors.rightMargin: window.width * 0.07
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: window.height * 0.20
                        Rectangle {
                            id: motor2tempbar
                            width: motor2image.width
                            height: motor2image.width * 0.05
                            color: "#A0A0A0"
                            anchors.top: motor2.bottom
                            anchors.topMargin: window.height * 0.02
                            Rectangle {
                                id: motor2bar
                                color: "#FFFFFF"
                                width: 0
                                height: parent.height
                            }
                        }
                    }
                }
                Image {
                    id: controlimage
                    source: "images/Control_Panel_with_text.png"
                    fillMode: Image.PreserveAspectFit
                    anchors.top: parent.top
                    anchors.topMargin: window.height * 0.20
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: window.height * 0.77
                    anchors.right: parent.right
                    anchors.rightMargin: window.width * 0.89
                    anchors.left: parent.left
                    anchors.leftMargin: window.width * 0.03
                    Rectangle{
                        id:controlfill
                        color: "transparent"
                        z: -1
                        x: -1 * (parent.width)
                        width: parent.width * 2.56
                        height: parent.height * 1.5
                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered: {
                                controlfill.color = "#C6C6C6"
                            }
                            onExited: {
                                controlfill.color = "transparent"
                            }
                            onClicked: {
                                controlfill.color = "#C6C6C6"
                                textupdate.text = "Control Panel Selected"
                            }
                            onReleased: {
                                controlfill.color = "transparent"
                            }
                        }
                    }
                }
                Image {
                    id: powerimage
                    source: "images/On_Button.png"
                    fillMode: Image.PreserveAspectFit
                    anchors.top: parent.top
                    anchors.topMargin: window.height * 0.70
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: window.height * 0.16
                    anchors.right: parent.right
                    anchors.rightMargin: window.width * 0.90
                    anchors.left: parent.left
                    anchors.leftMargin: window.width * 0.04

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if(window.count == 1) {
                                powerimage.source = "images/On_Button.png"
                                window.count = 0
                                textupdate.text = "Off Button Pressed"
                                motorspeed1.count1 = 0
                                motor1text.text = motorspeed1.count1
                                motor1bar.width = 0
                                motorspeed2.count2 = 0
                                motor2text.text = motorspeed2.count2
                                motor2bar.width = 0
                            }
                            else {
                                powerimage.source = "images/Off_Button.png"
                                window.count = 1
                                textupdate.text = "On Button Pressed"
                            }
                        }
                        onPressAndHold: {
                            textupdate.text = "App closing in 3 seconds"
                            delaytext.running = true
                        }
                        Timer {
                            id: delaytext
                            interval: 3000
                            running: false
                            onTriggered: Qt.quit()
                        }
                    }
                }
            }
            Rectangle {
                id:benchmarkswindow
                visible: false
                height: parent.height * 0.5
                width: parent.width * 0.5
                anchors.top: parent.top
                anchors.topMargin: parent.height * 0.25
                anchors.bottom: parent.bottom
                anchors.bottomMargin: parent.height * 0.25
                anchors.left: parent.left
                anchors.leftMargin: parent.width * 0.25
                anchors.right: parent.right
                anchors.rightMargin: parent.width * 0.25
                Rectangle {
                    id: index00
                    height: parent.height * 0.2
                    width: parent.width * 0.25
                    anchors.top:parent.top
                    anchors.left:parent.left
                   
                    Text {
                        id: index00text
                        text: qsTr("gl_manhattan_off")
                        color: "#F44336"
                        font.pixelSize: parent.width * 0.1
                        anchors.centerIn: parent
                    }
                }
                Rectangle {
                    id:index01
                    height: parent.height * 0.2
                    width: parent.width * 0.25
                    anchors.top:parent.top
                    anchors.left:index00.right
                   
                    Text {
                        id: index01text
                        text: qsTr("0")
                        color: "#F44336"
                        font.pixelSize: parent.width * 0.17
                        anchors.centerIn: parent
                    }
                }
                Rectangle {
                    id:index02
                    height: parent.height * 0.2
                    width: parent.width * 0.25
                    anchors.top:parent.top
                    anchors.left:index01.right
                   
                    Text {
                        id: index02text
                        text: qsTr("0")
                        color: "#F44336"
                        font.pixelSize: parent.width * 0.17
                        anchors.centerIn: parent
                    }
                }
                Rectangle {
                    id: index03
                    height: parent.height * 0.2
                    width: parent.width * 0.25
                    anchors.top:parent.top
                    anchors.left:index02.right
                    
                    Image {
                        id: playmanhat
                        scale: Qt.KeepAspectRatio
                        height: parent.height * 0.8
                        width: height  // To maintain the aspect ratio of the image
                        anchors.top: parent.top
                        anchors.topMargin: parent.height * 0.1
                        source: "images/playbutton.png"
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                if(leftMenuButton3.checked) {
                                    backend.playbutton1pressed()
                                    playbutton1timer.running = true
                                }
                            }
                        }
                    }
                    Timer {
                        id: playbutton1timer
                        interval: 70000
                        running: false
                        repeat: false
                        onTriggered: {
                            index01text.text = backend.playbutton1fps()
                            index02text.text = backend.playbutton1score()
                        }
                    }
                }
                Rectangle {
                    id: index13
                    height: parent.height * 0.2
                    width: parent.width * 0.25
                    anchors.top: index03.bottom
                    anchors.left:index02.right
                }
            }
            Item {
                width: 640
                height: 480
                
                Camera {
                    id: camera
                    //deviceId: QtMultimedia.defaultCamera.deviceId
                    captureMode: Camera.CaptureVideo
                    //videoRecorder.Codec: "video/mp4"
                    //videoRecorder.outputLocation: Qt.resolvedUrl("output.mp4")
                }

                VideoOutput {
                    id: videoOutput
                    source: camera
                    anchors.fill: parent
                    visible: false
                }
            }
        }
        Rectangle {
            id:cpuloadWindow
            anchors.left: mainWindow.left
            anchors.right: mainWindow.right
            anchors.top: mainWindow.bottom
            height: parent.height * 0.24
            color: "#17252A"
            Rectangle {
                id: gpubar
                width: parent.width * 0.1
                height: parent.height * 0.8
                color: "#A0A0A0"
                anchors.top: parent.top
                anchors.topMargin: parent.height * 0.1
                anchors.left: parent.left
                anchors.leftMargin: parent.width * 0.05
                Rectangle {
                    id: gpubarfill
                    color: "#FFFFFF"
                    width: parent.width
                    height: 0
                    anchors.bottom: parent.bottom
                }
                Text {
                    id: gpuload
                    text: qsTr("0")
                    color: "#F44336"
                    font.pixelSize: parent.width * 0.20
                    anchors.centerIn: parent
                }
               

            }
        }
        Timer {
            interval: 1000 // interval in milliseconds
            running: true // start the timer
            repeat: true // repeat the timer
            onTriggered: {
                gpuload.text = backend.getgpuload()
                gpubarfill.height = gpuload.text * gpubar.height * 0.01
            }
        }
        Rectangle {
            id: deviceInfo
            anchors.left: mainWindow.left
            anchors.right: mainWindow.right
            anchors.top: cpuloadWindow.bottom
            anchors.bottom: parent.bottom
            color: "#17252A"
            Text {
                id: info1
                text: "<font color=\"#FEFFFF\">Web: </font><font color=\"#FF0000\">https://ti.com/edgeai</font><font color=\"#FEFFFF\"> | Support: </font><font color=\"#FF0000\">https://e2e.ti.com/</font>"
                font.pointSize: 15
                anchors.verticalCenter: parent.verticalCenter
            }
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
